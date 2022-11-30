// SPDX-License-Identifier:MIT

pragma solidity ^0.8.7;

contract Attendance1
{
    struct Faculty
    {
        string id;
        string name;
    }

    struct Student
    {
        string id;
        string name;
    }

    struct Session
    {
        string s_id;
        Faculty faculty;
        uint password;
        uint start_time;
        uint end_time;
        string[] students_id;
    }

    mapping(string => Faculty) public faculty_details;
    mapping(string => Student) public student_details;
    mapping(string => Session) public session_details;

    function register_faculty(string memory _id, string memory _name) public 
    {

        Faculty memory new_faculty = Faculty(_id, _name);
        faculty_details[_id]=new_faculty;
    }

    function register_student(string memory _id, string memory _name) public 
    {
       Student memory new_student = Student(_id, _name);
       require(abi.encodePacked(student_details[_id].id).length == 0, "user already exists");

       student_details[_id] = new_student;
    }

    function create_session(string memory _s_id, string memory _faculty_id, uint _password, uint _start_time, uint _end_time ) public 
    {
        string[] memory emptyStudent;
        Session memory new_session = Session(_s_id, faculty_details[_faculty_id], _password, _start_time, _end_time,emptyStudent);
        session_details[_s_id] = new_session;
    }

    function mark_attendance(string memory _s_id, uint _password, string memory _st_id, uint current_time) public 
    {
        require(session_details[_s_id].password == _password, "Wrong Password");
        require(current_time >= session_details[_s_id].start_time && current_time <= session_details[_s_id].end_time,  "You are late broooooooo..." );
        session_details[_s_id].students_id.push(_st_id);

    }
    function get_session_students(string memory _s_id) public view returns(string[] memory)
    {
        return session_details[_s_id].students_id;
    }
}
