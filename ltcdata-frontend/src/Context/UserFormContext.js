import React, { useContext, ContextProvider, useState, Children } from "react";

const UserFormContext = React.createContext();

const FormValues = {
    id: null,
    User_Name: "",
    Full_Name: "",
    password: "",
    password_confirmation: "",
    Credentials: "",
    Access_Profile: 1,
    Facilities: ""
}

export function UserFormProvider({ children }) {
    const [formValues, setFormValues] = useState(FormValues);
    const [isNew, setIsNew] = useState(true);
    const resetFormValues = () => setFormValues(FormValues);

    return (
        <UserFormContext.Provider value={{ formValues, setFormValues, resetFormValues, isNew, setIsNew }}>
            {children}
        </UserFormContext.Provider>
    );

}

export { UserFormContext }