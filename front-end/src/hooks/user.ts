import { notification } from 'antd';
import { ISignUpPayload, IUser } from 'interfaces/user';
import { useState } from 'react';
import { userServices } from 'services';
const useUser = () => {
  const [actionLoading, setActionLoading] = useState(false);
  const [user, setUser] = useState<IUser>({} as IUser);
  const getme = async () => {
    try {
      setActionLoading(true);
      const res = await userServices.getMe();

      if (res) {
        if (res.fullName === '') userServices.logout();
        else setUser(res);
      }
    } finally {
      setActionLoading(false);
    }
  };
  const login = async (username: string, password: string) => {
    try {
      setActionLoading(true);
      const res = await userServices.login(username, password);
      console.log(res.token);
      if (res.token) {
        const token = res.token;
        localStorage.setItem('token', token);
        localStorage.setItem(
          'fullName',
          res.user.last_name + res.user.first_name
        );
        localStorage.setItem('role', res.user.role);
        localStorage.setItem('email', res.user.email);
      }
    } finally {
      setActionLoading(false);
    }
  };
  const signUp = async (payload: ISignUpPayload) => {
    try {
      setActionLoading(true);
      const res = await userServices.signUp(payload);
      if (res) {
        notification.success({
          message: 'Create user successfully',
        });
      }
    } catch (error) {
      notification.error({
        message: 'Create user failed',
      });
    } finally {
      setActionLoading(false);
    }
  };
  return {
    getme,
    user,
    login,
    signUp,
    actionLoading,
  };
};

export default {
  useUser,
};
