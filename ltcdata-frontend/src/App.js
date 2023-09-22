import React, { useContext, useState } from 'react';
import { Route, Routes, useNavigate } from 'react-router-dom';
import logo from './logo.svg';
import './App.css';
import favicon from './favicon.ico'
import Login from './Components/Login';
import ViewFacilityInfo from './Components/FacilityViews/ViewFacilityInfo';
import Sidebar from './Components/Sidebar';
import UserRequestList from './Components/UserRequests/UserRequestList';
import MainContent from './Components/MainContent';
import { UserContext, UserProvider } from './Context/UserContext';
import './Common.css'
import ExpandingButton from './Components/ExpandingButton';
import NewUserRequestForm from './Components/UserRequests/NewUserRequestForm';



function App() {
	const navigate = useNavigate();
	document.title = "LTCData Processing"
	const { username, resetState } = useContext(UserContext);
	function onLogout() {
		fetch('/logout', { method: 'POST' })
			.then(resetState())
			.then(navigate("/"));
	}

	function goHome() {
		if ([undefined, null, ""].includes(username))
			navigate('/')
		else
			navigate('/home')
	}

	const SiteAdmin = [
		{ Name: "User Management", Location: "/admin/user_requests" },
		{ Name: "Facility Management", Location: "/admin/edit_facility" },
	]

	const CorporateInfo = [
		{ Name: "Corporate Schedule", Location: "/home" },
		{ Name: "Corporate Time Records", Location: "/home" },
		{ Name: "Field Staff Directory", Location: "/home" },
		{ Name: "Corporate Staff Directory", Location: "/home" },
		{ Name: "Facility Directory", Location: "/home" },
	];

	return (
		<div className="App">


			<div className='primary-layout'>
				<Routes>
					<Route exact path="/" Component={Login} />

					<Route path='*' element={<React.Fragment>
						<div className='new-header'>
							<div className='standard-flex header-content'>
								<img src={favicon} alt='LTCData Logo' onClick={goHome} />
								<h1 className='centered-text'>LTCData Processing</h1>
								{[undefined, null, ""].includes(username) ? <div className='general-flex right-align'></div> :
									<nav className='general-flex right-align'>
										<ExpandingButton text="Site Admin" children={SiteAdmin} />
										<ExpandingButton text="Corporate" children={CorporateInfo} />
										<div onClick={onLogout}>
											<ExpandingButton text="Logout" primary_location={'/'} />
										</div>
									</nav>
								}
							</div>
						</div>
						<div className='main-content'>
							<MainContent />
						</div>
					</React.Fragment>} />
				</Routes>
			</div>
		</div >
	);
}

export default App;
