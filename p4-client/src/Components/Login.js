import React, { useState, useContext } from 'react'
import './Login.css'
import { useHistory } from 'react-router-dom'
import { UserContext } from '../Context/UserContext'

function Login() {
    const { username, setUsername } = useContext(UserContext);

    const [password, setPassword] = useState('')
    const [failedVisible, setFailed] = useState("none")
    const history = useHistory()

    function handleSubmit(event) {
        event.preventDefault()
        const data = {
            "Username": username,
            "Password": password
        }
        fetch('http://10.1.1.40:3000/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                "Access-Control-Allow-Origin": "*",
            },
            body: JSON.stringify(data), })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    history.push('/home')
                } else {
                    setFailed("block")
                }
            })
            .catch(error => { console.log(error) })
    };

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
                <img src="http://10.1.1.37/favicon.ico" alt='LTCData Logo' />
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
            </div>
        </div>
    )
}

export default Login