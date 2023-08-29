import React, { useState, useEffect, useContext } from "react";
import { Switch, Route, useLocation } from "react-router-dom";
import { useHistory } from "react-router";
import "./UserRequestList.css"
import NewUserRequestForm from "./NewUserRequestForm";
import Card from "../CommonUI/Card";
import { UserFormContext } from "../../Context/UserFormContext";
import { UserContext } from "../../Context/UserContext";

function UserRequestList() {
	const { userRequests, setUserRequests } = useContext(UserContext);
	const { formValues, setFormValues, resetFormValues } = useContext(UserFormContext);
	const history = useHistory();
	let editedRequest = null;
	useEffect(() => {
		fetch("http://localhost:3002/users")
			.then(response => response.json())
			.then(data => setUserRequests(data));
	}, []);

	function newRequest() {
		resetFormValues();
		editedRequest = null;
		history.push("/admin/user_requests/new");
	}

	function goToUserRequest(e) {
		let row = e.target.parentNode.querySelector("td:nth-of-type(2)") != null ? e.target.parentNode.querySelector("td:nth-of-type(2)") : e.target.parentNode.parentNode.querySelector("td:nth-of-type(2)");
		const txt = row.innerText;
		const req = userRequests.find(x => x.User_Name == txt);
		setFormValues(req);
		editedRequest = req;
		console.log("Going to user form with values: ", req)
		history.push(`/admin/user_requests/${txt}`)
	}
	return (<div className="page-root">
		<div className="page-content">
			<Card title="Users">
				<div onClick={newRequest} className="button">
					Add a New User
				</div>
				<table>
					<thead>
						<tr>
							<th>Name</th>
							<th>Username</th>
							<th >Facilities</th>
							<th className="extra-space">Date Added</th>
						</tr>
					</thead>
					<tbody>
						{userRequests?.map((userRequest) => (
							<tr className="user-row" key={userRequest.id} onClick={goToUserRequest}>
								<td>{userRequest.Full_Name}</td>
								<td >{userRequest.User_Name}</td>
								<td>{userRequest.Facilities.map(x => (<div key={x.id + "_" + userRequest.id} >{x.Report_Name}</div>))}</td>
								<td>{new Date(userRequest.created_at).toLocaleDateString()}</td>
							</tr>))}
					</tbody>
				</table>
			</Card>

			<NewUserRequestForm request={null} />
		</div>
	</div>)
}

export default UserRequestList;