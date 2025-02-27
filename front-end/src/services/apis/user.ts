import { browserHistory } from 'helpers';
import { getData, getResult } from 'helpers/request';
import {
  ILogin,
  ISignUpPayload,
  ISignUpResponse,
  IUser,
} from 'interfaces/user';
import { redirect } from 'react-router-dom';
import { requestServices } from 'services';
const { baseClient } = requestServices;
const isLoggedIn = () => {
  const token = localStorage.getItem('token');
  // return true;
  return !!token;
};
const getMe = (): IUser => {
  const user = {
    fullName: localStorage.getItem('fullName') || '',
    email: localStorage.getItem('email') || '',
    role: localStorage.getItem('role') || '',
  };
  return user;
};
const logout = async () => {
  console.log('logout');
  localStorage.removeItem('token');
  redirect('/login');
};
const login = (username: string, password: string): Promise<ILogin> => {
  return baseClient
    .post('/login', { email: username, password: password })
    .then(getResult);
};
const signUp = (payload: ISignUpPayload): Promise<ISignUpResponse> => {
  return baseClient.post('/register', payload).then(getData);
};
const getAccessToken = () => {
  return localStorage.getItem('token');
};

const denyAccess = () => {
  browserHistory.push('/403');
};

export default {
  signUp,
  isLoggedIn,
  logout,
  login,
  getAccessToken,
  denyAccess,
  getMe,
};
