import React, { useEffect, useState, useContext } from 'react';
import './NewUserRequestForm.css';
import { UserContext } from '../../Context/UserContext';
import { useHistory } from 'react-router-dom';
import Card from '../CommonUI/Card';

export default function NewUserRequestForm({ existingUser = {} }) {
	const [values, setValues] = useState(existingUser);
	const { username, user, accessProfiles, setAccessProfiles } = useContext(UserContext);
	const [possibleFacilities, setPossibleFacilities] = useState([]);
	const [selectedFacilities, setSelectedFacilities] = useState([]);
	const [addedFacilities, setAddedFacilities] = useState([]);
	const history = useHistory();
	useEffect(() => {
		if (username === "") {
			history.push('/');
		}
		fetch('http://localhost:3000/users/' + username + '/facilities')
			.then(response => response.json())
			.then(data => setPossibleFacilities(data));

		if (accessProfiles == null) {
			fetch('http://localhost:3000/access_profiles')
				.then(response => response.json())
				.then(data => setAccessProfiles(data));
		}
	}, []);

	function updateValues(e) {
		setValues({ ...values, [e.target.name]: e.target.value })
	}

	function updateSelection(e) {
		if (e.target.checked)
			setSelectedFacilities([...selectedFacilities, e.target.value])
		else
			setSelectedFacilities(selectedFacilities.filter(facility => facility.Report_Name !== e.target.value));
	}

	function submitForm(e) {
		if (values.id !== undefined) {
			console.log("existing")
		} else
			console.log("new");
		console.log(values);
	}

	return (
		<Card title="User Form">
			<form>
				<div className='new-user-form'>
					<div>
						<div>
							<input type='hidden' name='id' value={values.id} onChange={updateValues} />
							<label for='Full_Name'>User's Name</label>
							<input onChange={updateValues} className='login-textblock' name='Full_Name' id='Full_Name' type='text' />
						</div>
					</div>
					<div className='standard-flex'>
						<div>
							<label for='credentials'>Credentials</label>
							<input onChange={updateValues} className='login-textblock' name='credentials' id='credentials' type='text' />
						</div>
						<div>
							<label for='position'>Position</label>
							<select name='AccessProfile' className='select-dark' onChange={updateValues}>
								{accessProfiles === null || accessProfiles.length === 0 ? null : accessProfiles?.map((accessProfile) => (<option value={accessProfile.id}>{accessProfile.Friendly_Name}</option>))}
							</select>
						</div>
					</div>
					<div>
						<h3>Facility Access</h3>
						{possibleFacilities.map(x => (<div><input type='checkbox' value={x.Report_Name} onChange={updateSelection} />{x.Report_Name}</div>))}
					</div>
				</div>
				<div className='button' onClick={submitForm}>
					Submit User
				</div>
			</form>
		</Card>
	)
}