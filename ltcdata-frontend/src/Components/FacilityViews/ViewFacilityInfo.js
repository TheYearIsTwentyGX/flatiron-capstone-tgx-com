import React, { useState, useEffect, useContext } from "react";
import "./ViewFacilityInfo.css";
import Card from "../CommonUI/Card";
import { useNavigate } from "react-router-dom";
import { UserContext } from "../../Context/UserContext";

function ViewFacilityInfo() {
	const { username, userFacilities, setUserFacilities } = useContext(UserContext);
	const [selectedFacility, setSelectedFacility] = useState(null);
	const navigate = useNavigate();

	function handleFacilityChange(e) {
		if (e.target.value === null)
			return;
		let coserial = userFacilities.find(f => f.Report_Name === e.target.value).id;
		setSelectedFacility(userFacilities.find(x => x.id == coserial));
	}

	return (
		<div >
			<div className="page-root">
				<Card title="Facility Information">

					<select className="select-dark" onChange={handleFacilityChange}>
						<option value={null} />
						{userFacilities?.map((facility) => (<option value={facility.Report_Name}>{facility.Report_Name}</option>))}
					</select>
					<div className="cardContainer">
						<div className="general-flex card">
							<Card title="Company Number:" value={selectedFacility?.id ?? null} />
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
				</Card>
			</div>
		</div>
	);
}

export default ViewFacilityInfo;