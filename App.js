import React from 'react';
import { StyleSheet, Text, View } from 'react-native';
import Login from './src/components/Login/login';
import LoginForm from './src/components/Login/loginForm'
import ExpenseList from './src/components/Expense/ExpenseList';
import AddExpense from './src/components/Expense/AddExpense';
import { StackNavigator } from "react-navigation";
import ExpenseDetails from './src/components/Expense/ExpenseDetails'
import PieChart from './src/components/Chart/Chart'
const Application = StackNavigator(
  {
    Login: {screen: Login},
    ExpenseList: { screen: ExpenseList },
    ExpenseDetails: {screen: ExpenseDetails},
    AddExpense: {screen: AddExpense},
    PieChart: {screen: PieChart}
  },
  {
    headerMode: "screen",
    header: null
  }
);
export default class App extends React.Component {
  render() {
    return <Application />;
    
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});