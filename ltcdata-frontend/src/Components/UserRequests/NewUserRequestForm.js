import React, { useState, useEffect, useContext } from 'react';
import './NewUserRequestForm.css';
import { UserContext } from '../../Context/UserContext';
import { useLocation, useNavigate } from 'react-router-dom';
import Card from '../CommonUI/Card';
import { UserFormContext } from '../../Context/UserFormContext';

export default function NewUserRequestForm({ title = ["New User Form", "Submit New User"] }) {
	const { setUsername, setUser, username, accessProfiles, setAccessProfiles, userRequests, setUserRequests, setUserFacilities, userFacilities } = useContext(UserContext);
	const { formValues, setFormValues, resetFormValues } = useContext(UserFormContext);
	const [formType, setFormType] = useState(title);
	const [errors, setErrors] = useState([]);
	const navigate = useNavigate();
	//useEffect runs after the first render
	useEffect(() => {
		//Get the list of AccessProfiles, if it hasn't been fetched yet
		if (accessProfiles == null) {
			fetch('/access_profiles')
				.then(response => response.json())
				.then(data => setAccessProfiles(data));
		}
	}, []);

	//Handles the main textboxes
	function updateMainValues(e) {
		console.log("Changing formValues: ", formValues)
		setFormValues({ ...formValues, [e.target.name]: e.target.value });

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
		let formObj = { ...formValues };
		formObj.Facilities = formObj.Facilities.filter(x => x.Access_Profile != '');
		fetch('/users/' + postOrPatch[0], {
			method: postOrPatch[1],
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(formObj)
		}).then(response => { return { response: response, data: response.json() } })
			.then(({ response, data }) => {
				if ([201, 200].includes(response.status) == false || [undefined, null].includes(data?.errors) == false) {
					throw new Error(data?.errors?.length > 0 ? data.errors : ["An unknown error has occurred"]);
				} else
					return data;
			}).then(data => {
				if ([undefined, null, ""].includes(username)) {
					navigate('/');
				} else {
					let oldRequests = userRequests?.filter(x => x.id != data.id);
					setUserRequests([...oldRequests, data]);
					resetFormValues();
					navigate('/admin/user_requests');
				}

			})
			.catch(error => { console.log(error); setErrors(error) })
	}

	return (
		<Card title={(formValues?.id > 0 ? "Modify User Form" : title[0])}>
			<div className='error-section'>

				{errors.length > 0 ? <div className='error-card'>
					{errors.map(x => (<div className='error' key={x}>{x}</div>))}
				</div> : null}
			</div>


			<form className='user-form'>
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
						<label htmlFor='Email'>Email</label>
						<input onChange={updateMainValues} value={formValues.Email_Address} className='login-textblock' name='Email_Address' id='Email' type='text' />
					</div>
					{userFacilities.length < 1 ? <div className='standard-flex' /> :
						<div className='facility-section'>
							<h3>Facility Access</h3>
							<div className='standard-flex'>
								<div className='upright-flex'>
									<table>
										<tbody>
											{userFacilities.map(x => (<tr key={x.id + "_tr"}>
												<td>
													<input key={x.id + "_cb"} type='checkbox' value={x.id} onChange={updateFacilities} checked={formValues.Facilities.filter(f => f.id == x.id && f.Access_Profile != null).length > 0} />
												</td>
												<td>
													{x.Report_Name}
												</td>
												<td>
													<select className='select-light' value={formValues.Facilities.find(z => z.id?.toString() == x.id?.toString())?.Access_Profile ?? ""} name={x.id} onChange={updateProfileForFacility}>
														<option value="" />
														{(accessProfiles != null && accessProfiles != undefined && accessProfiles.length > 0 ? accessProfiles.map(y => (<option key={y.Friendly_Name + "_" + y.id} value={y.id}>{y.Friendly_Name}</option>)) : null)}
													</select>
												</td>
											</tr>
											))}
										</tbody>
									</table>
								</div>
							</div>
						</div>}
				</div>
				<div className='button' onClick={submitForm}>
					{(formValues?.id > 0 ? "Submit Modified User" : title[1])}
				</div>
			</form>
		</Card>
	)
}