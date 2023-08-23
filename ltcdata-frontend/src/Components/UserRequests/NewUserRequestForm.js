import React, { useEffect, useState, useContext } from 'react';
import './NewUserRequestForm.css';
import { UserContext } from '../../Context/UserContext';
import { useHistory, useLocation } from 'react-router-dom';
import Card from '../CommonUI/Card';
import { UserFormContext } from '../../Context/UserFormContext';

export default function NewUserRequestForm({ request = null }) {
	const { username, accessProfiles, setAccessProfiles, userRequests, setUserRequests, } = useContext(UserContext);
	const { formValues, setFormValues, resetFormValues } = useContext(UserFormContext);
	const [possibleFacilities, setPossibleFacilities] = useState([]);
	const [selectedFacilities, setSelectedFacilities] = useState([]);
	const [newOrOld, setNewOrOld] = useState(true);
	const history = useHistory();
	const location = useLocation();
	useEffect(() => {
		if (username === "") {
			history.push('/');
		}
		fetch('http://localhost:3002/users/' + username + '/facilities')
			.then(response => response.json())
			.then(data => setPossibleFacilities(data));

		if (accessProfiles == null) {
			fetch('http://localhost:3002/access_profiles')
				.then(response => response.json())
				.then(data => setAccessProfiles(data));
		}
		if (Array.isArray(formValues.Facilities))
			setSelectedFacilities(formValues.Facilities.map(x => x.Coserial));
	}, []);

	function updateValues(e) {
		setFormValues(formValues => ({ ...formValues, [e.target.name]: e.target.value }));
	}

	function updateSelection(e) {
		if (e.target.checked)
			setSelectedFacilities([...selectedFacilities, e.target.value])
		else
			setSelectedFacilities(selectedFacilities.filter(facility => facility.Coserial != e.target.value));
	}

	function submitForm(e) {
		const postOrPatch = [null, undefined].includes(formValues.id) ? ['', 'POST'] : [formValues.id, 'PATCH'];
		const body = formValues;
		body.Facilities = selectedFacilities.join(',');
		fetch('http://localhost:3002/users/' + postOrPatch[0], {
			method: postOrPatch[1],
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(body)
		}).then(response => response.json())
			.then(data => {
				let oldRequests = userRequests?.filter(x => x.id != data.id) ?? [];
				setUserRequests([...oldRequests, data]);
				resetFormValues();
				history.push('/admin/user_requests');
			});
	}

	return (
		<Card title="User Form">
			<form>
				<div className='new-user-form'>
					<div className='standard-flex'>
						<div>
							<label for='Full_Name'>Full Name</label>
							<input onChange={updateValues} value={formValues.Full_Name} className='login-textblock' name='Full_Name' id='Full_Name' type='text' />
						</div>
						<div>

							<label for='User_Name'>Username</label>
							<input onChange={updateValues} value={formValues.User_Name} className='login-textblock' name='User_Name' id='User_Name' type='text' />
						</div>
					</div>

					<div className='standard-flex'>
						<div>
							<label for='password'>Password</label>
							<input onChange={updateValues} value={formValues.password} className='login-textblock' name='password' id='password' type='password' />
						</div>
						<div>
							<label for='password_confirmation'>Password Confirmation</label>
							<input onChange={updateValues} value={formValues.password_confirmation} className='login-textblock' name='password_confirmation' id='password_confirmation' type='password' />
						</div>
					</div>

					<div>
						<label for='credentials'>Credentials</label>
						<input onChange={updateValues} value={formValues.Credentials} className='login-textblock' name='Credentials' id='Credentials' type='text' />
					</div>
					<div>
						<label for='position'>Position</label>
						<select name='Access_Profile' className='select-dark' value={formValues.Access_Profile} onChange={updateValues}>
							{accessProfiles === null || accessProfiles.length === 0 ? null : accessProfiles?.map((accessProfile) => (<option value={accessProfile.id}>{accessProfile.Friendly_Name}</option>))}
						</select>
					</div>

					<div>
						<h3>Facility Access</h3>
						{possibleFacilities.map(x => (<div><input type='checkbox' value={x.Coserial} onChange={updateSelection} />{x.Report_Name}</div>))}
					</div>
				</div>
				<div className='button' onClick={submitForm}>
					Submit User
				</div>
			</form>
		</Card>
	)
}