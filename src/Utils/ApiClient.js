import { AsyncStorage } from "react-native";
export const URL = "http://172.20.10.3/XpenseAPI/api/";
export const GETEXPENSES = URL + "Expense/GetExpense/1";
export const ADD_EXPENSE_URL = URL + "Expense/CreateExpense";
export const UPDATE_EXPENSE_URL = URL + "Expense/UpdateExpense/"
export const DELETE_EXPENSE_URL = URL + "Expense/DeleteExpense/"

export default class ApiClient {


  static fetchExpenses = async () => {
    console.log("API WE ARE HERE");
    var response = await fetch(GETEXPENSES, {
      method: "GET"
    });
    console.log("API WE ARE HERE 2");
    if (response.status >= 200 && response.status < 300) {
      console.log("response-ul e bun")
      var jsonRes = await response.json();
    }
    else {
      console.log("response-ul nu e ok")
    }
    return jsonRes;
  }


  static addExpense = async (type, value) => {
    var userid = 1
    var n1=type;
    var n2=parseFloat(value);
    console.log(n1+n2+n3);
    var params = {
      Type: n1,
      Value: n2,
      UserId: userid
    };
    var formBody = [];
    for (var property in params) {
      var encodedKey = encodeURIComponent(property);
      var encodedValue = encodeURIComponent(params[property]);
      formBody.push(encodedKey + "=" + encodedValue);
    }
    formBody = formBody.join("&");
    console.log(formBody);

    var response = await fetch(ADD_EXPENSE_URL, {
      method: "POST",
      body: formBody,
      headers: {"Content-Type": 'application/x-www-form-urlencoded'}
    });

    if (response.status >= 200 && response.status < 300) {
      var jsonRes = await response.json();
      if (jsonRes) {
        console.log(jsonRes.food);
      } else {
        console.log("jsonRes does not exist")
      }
    } else {
      console.log("Statusul de la response este "+response.status);
      console.log("Error response status not between [220,300)");
    }
  }


  static updateExpense = async (expenseId, type, value, userId) => {
    var userId = 1
    var params = {
      Id: expenseId,
      Value: parseFloat( value),
      Type: type,
      UserId: userId
    };

    console.log(params);
    var formBody = [];
    for (var property in params) {
      var encodedKey = encodeURIComponent(property);
      var encodedValue = encodeURIComponent(params[property]);
      formBody.push(encodedKey + "=" + encodedValue);
    }
    formBody = formBody.join("&");

    var response = await fetch(UPDATE_EXPENSE_URL + foodId.toString(), {
      method: "PUT",
      body: formBody,
      headers: {"Content-Type": 'application/x-www-form-urlencoded'}
    });

    if (response.status >= 200 && response.status < 300) {
      var jsonRes = await response.json();
      console.log(jsonRes);
    } else {
      console.log(response.status);
    }
  }

  static deleteExpense = async id => {

    var token = await AsyncStorage.getItem("token");

    var response = await fetch(DELETE_EXPENSE_URL + id, {
      method: "DELETE"
    });

    if (response.status >= 200 && response.status < 300) {
      var jsonRes = await response.json();
      if (jsonRes.Success === true) {
        return { Success: true };
      }
    }
    return { Success: false };
  };

}