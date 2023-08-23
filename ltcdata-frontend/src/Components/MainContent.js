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
	const [selectedFacility, setSelectedFacility] = useState({});

	function facilityFormSubmitted(e, isNewFacility) {
		const postOrPatch = isNewFacility ? ['', 'POST'] : [e.Coserial, 'PATCH'];
		fetch('http://localhost:3002/facilities/' + postOrPatch[0], {
			method: postOrPatch[1],
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(e)
		}).then(response => response.json())
			.then(data => {
				if (isNewFacility)
					setUserFacilities([...userFacilities, data.Coserial]);
				else
					setUserFacilities(userFacilities.map(f => f.Coserial == data.Coserial ? data : f));
			})
	}

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
				<Route path="/admin/edit_facility">
					<FacilityEdit SelectedFacility={selectedFacility} submitFacility={facilityFormSubmitted} />
				</Route>
			</Switch>
		</div>
	)
}

export default MainContent;