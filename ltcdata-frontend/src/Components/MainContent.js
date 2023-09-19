import { Route, Routes, useNavigate } from 'react-router-dom';
import Login from './Login';
import UserRequestList from './UserRequests/UserRequestList';
import { UserContext } from '../Context/UserContext';
import React, { useContext, useEffect, useState } from 'react';
import { UserFormProvider } from '../Context/UserFormContext';
import ViewFacilityInfo from './FacilityViews/ViewFacilityInfo';
import FacilityEdit from './FacilityViews/FacilityEdit';

function MainContent() {
	const { setUser, username, setUsername, userFacilities, setUserFacilities } = useContext(UserContext);
	const navigate = useNavigate();

	useEffect(() => {
		if (username === "") {
			fetch('/session')
				.then(response => response.json())
				.then(data => {
					console.log(data);
					if (data.User_Name == null || data.User_Name == undefined || data.User_Name == "")
						navigate('/');
					else {
						setUsername(data.User_Name); setUser(data); setUserFacilities(data.Facilities);
					}
				})
				.catch(error => navigate('/'));
		}
	}, []);


	return (
		<div className='proot'>
			<Routes>
				<Route path="/home" element={<ViewFacilityInfo username={username} />} />
				<Route path="/admin/user_requests/*" element={
					<React.Fragment>
						<UserFormProvider>
							<UserRequestList />
						</UserFormProvider>
					</React.Fragment>
				}>
				</Route>
				<Route path={"/admin/edit_facility"} component={FacilityEdit} />
				<Route path={"/admin/edit_facility/:id"} component={FacilityEdit} />
			</Routes>
		</div>
	)
}

export default MainContent;