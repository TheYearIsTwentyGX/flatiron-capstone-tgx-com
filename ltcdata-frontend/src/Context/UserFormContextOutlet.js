import { Outlet } from "react-router-dom";
import { UserFormProvider } from "./UserFormContext";

function UserFormContextOutlet() {
  return (
    <UserFormProvider>
      <Outlet />
    </UserFormProvider>
  )
}

export default UserFormContextOutlet;