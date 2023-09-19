import React from "react";
import { useNavigate } from "react-router-dom";
import "./Sidebar.css"
import ExpandingButton from "./ExpandingButton";

function Sidebar({ onLogout }) {
    const navigate = useNavigate();

    const SiteAdmin = [
        { Name: "User Requests", Location: "/admin/user_requests" }
    ]

    const CorporateInfo = [
        { Name: "Corporate Schedule", Location: "/home" },
        { Name: "Corporate Time Records", Location: "/home" },
        { Name: "Field Staff Directory", Location: "/home" },
        { Name: "Corporate Staff Directory", Location: "/home" },
        { Name: "Facility Directory", Location: "/home" },
    ];

    return (<div className="sidebar-root">
        <h1>Sidebar</h1>
        <ExpandingButton text="Site Admin" children={SiteAdmin} />
        <ExpandingButton text="Corporate Info" children={CorporateInfo}></ExpandingButton>
        <div className="button sidebar-button" onClick={onLogout}>Logout</div>
    </div>)
}

export default Sidebar;