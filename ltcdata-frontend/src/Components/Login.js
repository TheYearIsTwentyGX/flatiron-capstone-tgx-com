import React, { useState, useContext } from 'react'
import './Login.css'
import { useNavigate } from 'react-router-dom'
import { UserContext } from '../Context/UserContext'

function Login() {
	const { setUser, setUserFacilities, username, setUsername } = useContext(UserContext);

	const [password, setPassword] = useState('')
	const [failedVisible, setFailed] = useState("none")
	const navigate = useNavigate()

	function handleSubmit(event) {
		event.preventDefault()
		const data = {
			"Username": username,
			"Password": password
		}
		fetch('/login', {
			method: 'POST',
			body: JSON.stringify(data),
			headers: {
				"Content-Type": "application/json"
			}
		})
			.then(response => {
				if (response.status == 201) {
					getUserInfo();
					navigate('/home')
				}
				else
					setFailed("block")
			})
			.catch(error => { console.log(error) })
	};

	function getUserInfo() {
		fetch(`/users/${username}`)
			.then(response => response.json())
			.then(data => {
				setUsername(data.User_Name); setUser(data); setUserFacilities(data.Facilities);
			})
	}

	function handleTextChange(e) {
		if (e.target.id === 'username') {
			setUsername(e.target.value)
		} else if (e.target.id === 'password') {
			setPassword(e.target.value)
		}
	}

	return (
		<div className='login-layout'>
			<div className='logo'>
			</div>
			<div className='header'>
				<h1>LTCData Processing</h1>
			</div>
			<div className='bluespace'></div>
			<div className='formDiv'>
				<h2 className='loginText'>Welcome to LTCData</h2>
				<h4 className='loginText'>Please enter your username and password:</h4>
				<h4 style={{ color: 'red', display: failedVisible }}>Login failed. Please try again.</h4>
				<form className='form' onSubmit={handleSubmit}>
					<div>
						<label htmlFor='username'>Username</label>
					</div>
					<input className='login-textblock' type='text' onChange={handleTextChange} value={username} id='username' name='username' />
					<div>
						<label htmlFor='password'>Password</label>
					</div>
					<input className='login-textblock' type='password' id='password' name='password' onChange={handleTextChange} value={password} />
					<div>
						<input className='login-submit' type='submit' value='Login' />
					</div>
				</form>
				<input className='login-submit' type='button' value='Sign Up' onClick={() => navigate('/signup')} />
			</div>
		</div>
	)
}

export default Login