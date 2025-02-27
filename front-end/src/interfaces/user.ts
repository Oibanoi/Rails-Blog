export interface ILogin {
  token: string;
  tokenType: string;
  user:IUserLogin;
}
export interface IUserLogin{
  id: number;
  email: string;
  first_name:string;
  last_name:string;
  role:string
}
export interface ISignUpPayload {
  fullName: string;
  email: string;
  password: string;
}

export interface ISignUpResponse {
  fullName: string;
  email: string;
  id: number;
  role: string;
}

export interface IUser {
  fullName: string;
  email: string;
  role: string;
  lastLogin?: string;
}
