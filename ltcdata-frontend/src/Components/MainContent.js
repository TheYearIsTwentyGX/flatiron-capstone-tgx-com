import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Login from './Login';
import UserRequestList from './UserRequests/UserRequestList';
import { UserContext } from '../Context/UserContext';
import { useContext, useEffect, useState } from 'react';
import { UserFormProvider } from '../Context/UserFormContext';
import ViewFacilityInfo from './FacilityViews/ViewFacilityInfo';
import FacilityEdit from './FacilityViews/FacilityEdit';
import { useHistory } from 'react-router-dom/cjs/react-router-dom.min';

function MainContent() {
	const { setUser, username, setUsername, userFacilities, setUserFacilities } = useContext(UserContext);
	const history = useHistory();

	useEffect(() => {
		if (username === "") {
			fetch('/session')
				.then(response => response.json())
				.then(data => {
					console.log(data);
					if (data.User_Name == null || data.User_Name == undefined || data.User_Name == "")
						history.push('/');
					else {
						setUsername(data.User_Name); setUser(data); setUserFacilities(data.Facilities);
					}
				})
				.catch(error => history.push('/'));
		}
	}, []);


	return (
		<div className='proot'>
			<Switch>
				<Route exact path="/">
					<Login username={username} setUsername={setUsername} />
				</Route>
				<Route path="/home">
					<ViewFacilityInfo username={username} />
				</Route>
				<Route path="/admin/user_requests">
					<UserFormProvider>
						<UserRequestList />
					</UserFormProvider>
				</Route>
				<Route path={["/admin/edit_facility/:id", "/admin/edit_facility"]} component={FacilityEdit} />
			</Switch>
		</div>
	)
}

export default MainContent;