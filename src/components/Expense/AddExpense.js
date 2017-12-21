import React, { Component } from "react";
import {
    View,
    Text,
    StyleSheet,
    AsyncStorage,
    Picker,
    Alert,
    TextInput,
    TouchableOpacity
} from "react-native";
import ApiClient from "../../Utils/ApiClient";

export default class AddExpense extends Component {

    static navigationOptions = {
        title: "Add New Expense",
        headerStyle: { backgroundColor: "#CE563C" },
        headerTitleStyle: { color: "white" }
    };
    constructor(props) {
        super(props);
        this.state = {
            type: "",
            value: 0,
            currentlySelectedType: {key:"1",value:"food"}
        };
    }

    componentDidMount() {
    }

    save = async () => {
        var type = this.state.currentlySelectedType;
        var value = parseFloat(this.state.value);
        console.log(type + value );
        ApiClient.addExpense(type, value)
            .then(alert(type + " added successfully!"))
            .catch((error) => {
                console.log("Api call error");
                alert(error.message);
            })


        this.props.navigation.state.params.onGoBack();
        this.props.navigation.goBack();
    };

    render() {

        const { state } = this.props.navigation;
        var expense = state.params ? state.params.expense : "<undefined>";
        var options = [{ key: "1", value: "food" }, { key: "2", value: "taxes" }, { key: "3", value: "taxi" }];

        let types = options.map(data => {
            return (
                <Picker.Item
                    key={data.key}
                    value={data.key}
                    label={data.value}
                />
            );
        });
        return (
            <View style={styles.container} >
               
                <TextInput style={styles.input} placeholder="value"
                    onChangeText={value => this.setState({ value })}
                />
                <Picker
                selectedType={this.state.currentlySelectedType}
                onValueChange={(itemValue, itemIndex) =>
                  this.setState({ currentlySelectedType: itemValue })
                }
                >{types}</Picker>
                <TouchableOpacity
                    style={styles.button}
                    onPress={this.save}>
                    <Text style={styles.textBtn}>Save</Text>
                </TouchableOpacity>
            </View>
        );
    }
}


const styles = StyleSheet.create(
    {
        expenseType: {
            color: '#E91E63',
            fontSize: 25,
            textAlign: 'center',
        },

        container: {
            flex: 1,
            paddingTop: 50,
            padding: 20,
            backgroundColor: "#D0B3AD"
        },
        text: {
            justifyContent: "center",
            alignItems: "center",
            backgroundColor: "#2c3e50",
            color: "white",
            fontSize: 30
        },

        input: {
            height: 40,
            backgroundColor: 'rgba(255,255,255,0.2)',
            marginBottom: 20,
        },

        button: {
            backgroundColor: "#832713",
            paddingVertical: 15,
            marginTop: 30
        },

        textBtn: {
            textAlign: 'center',
            fontWeight: '700'
        }
    });