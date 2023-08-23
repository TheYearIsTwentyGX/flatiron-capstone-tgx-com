import Card from "../CommonUI/Card";
import "./FacilityEdit.css";
import { useState, useEffect, useContext } from "react";
import { UserContext } from "../../Context/UserContext";

export default function FacilityEdit({ SelectedFacility = {}, submitFacility }) {

  const { userFacilities, setUserFacilities } = useContext(UserContext);

  const [formValues, setFormValues] = useState({
    Coserial: SelectedFacility.Coserial ?? null,
    Report_Name: SelectedFacility.Report_Name ?? null,
    Address1: SelectedFacility.Address1 ?? null,
    Address2: SelectedFacility.Address2 ?? null,
    City: SelectedFacility.City ?? null,
    State: SelectedFacility.State ?? null,
    Zip: SelectedFacility.Zip ?? null,
    Phone: SelectedFacility.Phone ?? null,
    Fax: SelectedFacility.Fax ?? null,
  });

  function onInputChange(e) {
    setFormValues({ ...formValues, [e.target.name]: e.target.value });
    console.log("Updating formValues. Previous value: ", formValues);
  }
  function editedFacilityChanged(e) {
    setFormValues(userFacilities.find(f => f.Coserial == e.target.value));
  }

  return (
    <Card title="Edit Facility">
      <label for='selected-facility'>Facility to Edit</label>
      <select name='selected-facility' className='select-dark' onChange={editedFacilityChanged}>
        {userFacilities?.map((facility) => (<option value={facility.Coserial}>{facility.Report_Name}</option>))}
      </select>
      <div className="facility-card">
        <div>
          <label htmlFor="Coserial">Company Number:</label>
          <input onChange={onInputChange} type="text" value={formValues.Coserial} className="form-textblock" name="Coserial" />
          <label htmlFor="Report_Name">Company Name:</label>
          <input onChange={onInputChange} type="text" value={formValues.Report_Name} className="form-textblock" name="Report_Name" />
        </div>
        <div>
          <label htmlFor="Phone">Phone Number:</label>
          <input onChange={onInputChange} type="text" value={formValues.Phone} className="form-textblock" name="Phone" />
          <label htmlFor="Fax">Fax Number:</label>
          <input onChange={onInputChange} type="text" value={formValues.Fax} className="form-textblock" name="Fax" />
        </div>
        <div>
        </div>
        <div>
          <label htmlFor="Address1">Address 1:</label>
          <input onChange={onInputChange} type="text" value={formValues.Address1} className="form-textblock" name="Address1" />
          <label htmlFor="Address2">Address 2:</label>
          <input onChange={onInputChange} type="text" value={formValues.Address2} className="form-textblock" name="Address2" />
          <label htmlFor="City">City:</label>
          <input onChange={onInputChange} type="text" value={formValues.City} className="form-textblock" name="City" />
          <label htmlFor="State">State:</label>
          <input onChange={onInputChange} type="text" value={formValues.State} className="form-textblock" name="State" />
          <label htmlFor="Zip">Zip:</label>
          <input onChange={onInputChange} type="text" value={formValues.Zip} className="form-textblock" name="Zip" />
        </div>
      </div>
    </Card>)
}