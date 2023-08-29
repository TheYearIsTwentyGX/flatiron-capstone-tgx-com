import React, { useEffect, useState, useContext } from 'react';
import './NewUserRequestForm.css';
import { UserContext } from '../../Context/UserContext';
import { useHistory, useLocation } from 'react-router-dom';
import Card from '../CommonUI/Card';
import { UserFormContext } from '../../Context/UserFormContext';

export default function NewUserRequestForm({ request = null }) {
	const { username, accessProfiles, setAccessProfiles, userRequests, setUserRequests, userFacilities } = useContext(UserContext);
	const { formValues, setFormValues, resetFormValues } = useContext(UserFormContext);
	const history = useHistory();
	//useEffect runs after the first render
	useEffect(() => {
		//Push back to login if no username
		if (username === "") {
			history.push('/');
		}
		//Get the list of AccessProfiles, if it hasn't been fetched yet
		if (accessProfiles == null) {
			fetch('http://localhost:3002/access_profiles')
				.then(response => response.json())
				.then(data => setAccessProfiles(data));
		}
	}, []);

	//Handles the main textboxes
	function updateMainValues(e) {
		let oldVals = formValues;
		oldVals[e.target.name] = e.target.value;
		setFormValues(oldVals);
	}

	//Handles the checkboxes for facilities
	function updateFacilities(e) {
		let oldFacs = formValues.Facilities;
		if (e.target.checked)
			oldFacs.push({ id: e.target.value, Access_Profile: "" });
		else
			oldFacs = oldFacs.filter(x => x.id != e.target.value);
		setFormValues({ ...formValues, Facilities: oldFacs });
	}

	//Handles the dropdowns for facility access profiles
	function updateProfileForFacility(e) {
		let oldProfs = formValues.Facilities;
		if (oldProfs.some(x => x.id == e.target.name)) {
			oldProfs.find(x => x.id == e.target.name).Access_Profile = e.target.value;
			setFormValues({ ...formValues, Facilities: oldProfs });
		}
	}

	function submitForm(e) {
		const postOrPatch = [null, undefined].includes(formValues.id) ? ['', 'POST'] : [formValues.id, 'PATCH'];
		fetch('http://localhost:3002/users/' + postOrPatch[0], {
			method: postOrPatch[1],
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(formValues)
		}).then(response => response.json())
			.then(data => {
				console.log(data);
				let oldRequests = userRequests?.filter(x => x.id != data.id);
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
							<label htmlFor='Full_Name'>Full Name</label>
							<input onChange={updateMainValues} value={formValues.Full_Name} className='login-textblock' name='Full_Name' id='Full_Name' type='text' />
						</div>
						<div>

							<label htmlFor='User_Name'>Username</label>
							<input onChange={updateMainValues} value={formValues.User_Name} className='login-textblock' name='User_Name' id='User_Name' type='text' />
						</div>
					</div>

					<div className='standard-flex'>
						<div>
							<label htmlFor='password'>Password</label>
							<input onChange={updateMainValues} value={formValues.password} className='login-textblock' name='password' id='password' type='password' />
						</div>
						<div>
							<label htmlFor='password_confirmation'>Password Confirmation</label>
							<input onChange={updateMainValues} value={formValues.password_confirmation} className='login-textblock' name='password_confirmation' id='password_confirmation' type='password' />
						</div>
					</div>

					<div>
						<h3>Facility Access</h3>
						{userFacilities.map(x => (
							<div key={x.id}>
								<input type='checkbox' value={x.id} onChange={updateFacilities} checked={formValues.Facilities.filter(f => f.id == x.id && f.Access_Profile != null).length > 0} />

								{x.Report_Name}
								<select className='select-dark' value={formValues.Facilities.find(z => z.id?.toString() == x.id?.toString())?.Access_Profile ?? ""} name={x.id} onChange={updateProfileForFacility}>
									<option value="" />
									{(accessProfiles != null && accessProfiles != undefined && accessProfiles.length > 0 ? accessProfiles.map(y => (<option key={y.Friendly_Name + "_" + y.id} value={y.id}>{y.Friendly_Name}</option>)) : null)}
								</select>
							</div>))}
					</div>


				</div>
				<div className='button' onClick={submitForm}>
					Submit User
				</div>
			</form>
		</Card>
	)
}