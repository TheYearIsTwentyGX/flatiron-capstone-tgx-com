import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Login from './Login';
import UserRequestList from './UserRequests/UserRequestList';
import { UserContext } from '../Context/UserContext';
import { useContext, useState } from 'react';
import { UserFormProvider } from '../Context/UserFormContext';
import ViewFacilityInfo from './FacilityViews/ViewFacilityInfo';
import FacilityEdit from './FacilityViews/FacilityEdit';

function MainContent() {
	const { username, setUsername, userFacilities, setUserFacilities } = useContext(UserContext);



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