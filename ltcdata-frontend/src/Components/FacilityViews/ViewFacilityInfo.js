import React, { useState, useEffect, useContext } from "react";
import "./ViewFacilityInfo.css";
import Card from "../CommonUI/Card";
import { useHistory } from "react-router-dom/cjs/react-router-dom.min";
import { UserContext } from "../../Context/UserContext";

function ViewFacilityInfo() {
	const { username } = useContext(UserContext);
	const [userFacilities, setUserFacilities] = useState([]);
	const [selectedFacility, setSelectedFacility] = useState(null);
	const history = useHistory();
	useEffect(() => {
		if (username === '') {
			history.push('/');
			return;
		}
		fetch("http://localhost:3002/facilities")
			.then(response => response.json())
			.then(data => { console.log(data); return data; })
			.then(data => { setUserFacilities(data); });
	}, [username]);

	function handleFacilityChange(e) {
		let coserial = userFacilities.find(f => f.Report_Name === e.target.value).Coserial;
		setSelectedFacility(userFacilities.find(x => x.Coserial == coserial));
	}

	return (
		<div >
			<div className="page-root">
				<div>
					<div>
						<h1>Facility Information</h1>
					</div>
					<select className="select-dark" onChange={handleFacilityChange}>
						{userFacilities?.map((facility) => (<option value={facility.Report_Name}>{facility.Report_Name}</option>))}
					</select>
				</div>
				<div className="cardContainer">
					<div className="general-flex card">
						<Card title="Company Number:" value={selectedFacility?.Coserial ?? null} />
						<Card title="Phone Number:" value={selectedFacility?.Phone ?? null} />
						<Card title="Fax Number:" value={selectedFacility?.Fax ?? null} />
						<Card title="Address:">
							<div>
								<p>{selectedFacility?.Address1 ?? null}</p>
								<p>{selectedFacility?.Address2 ?? null}</p>
								<p>{selectedFacility?.City ?? null} {selectedFacility?.State ?? null} {selectedFacility?.Zip ?? null}</p>
							</div>
						</Card>
					</div>
				</div>
			</div>
		</div>
	);
}

export default ViewFacilityInfo;