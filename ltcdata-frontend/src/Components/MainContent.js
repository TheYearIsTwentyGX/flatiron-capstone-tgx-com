import { Route, Routes, useNavigate, useLocation } from 'react-router-dom';
import Login from './Login';
import UserRequestList from './UserRequests/UserRequestList';
import { UserContext } from '../Context/UserContext';
import React, { useContext, useEffect, useState } from 'react';
import { UserFormProvider } from '../Context/UserFormContext';
import ViewFacilityInfo from './FacilityViews/ViewFacilityInfo';
import FacilityEdit from './FacilityViews/FacilityEdit';
import NewUserRequestForm from './UserRequests/NewUserRequestForm';
import UserFormContextOutlet from '../Context/UserFormContextOutlet';

function MainContent() {
	const { setUser, username, setUsername, userFacilities, setUserFacilities } = useContext(UserContext);
	const [formType, setFormType] = useState([]);
	const navigate = useNavigate();
	const location = useLocation();
	useEffect(() => {
		if (location.pathname === "/signup") {
			setFormType(["Signup for LTCData", "Create Account"]);
			return;
		}
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
			<UserFormProvider>

				<Routes>
					<Route path="/home" element={<ViewFacilityInfo username={username} />} />
					<Route path="/admin/edit_facility/" element={<FacilityEdit />} />
					<Route path="/admin/edit_facility/:id" element={<FacilityEdit />} />
					<Route exact path="/signup" element={
						<div className='general-flex'>
							<div style={{ width: '30%' }} />
							<NewUserRequestForm title={["Sign Up for LTCData", "Create Account"]} />
							<div style={{ width: '30%' }} />
						</div>
					} />
					<Route path="/admin/user_requests" element={<UserRequestList />} />
				</Routes>
			</UserFormProvider>
		</div>
	)
}

export default MainContent;