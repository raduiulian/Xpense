import React, { Component } from 'react';
import {
    AppRegistry,
    FlatList,
    StyleSheet,
    Text,
    View,
    TouchableOpacity,
    ScrollView,
    Image,
    Alert,
    TextInput,
    Linking
} from 'react-native';
import ApiClient from "../../Utils/ApiClient";

export default class ExpenseDetails extends Component {
    static navigationOptions = {
        title: "Details",
        headerStyle: { backgroundColor: "#CE563C" },
        headerTitleStyle: { color: "white" },
    };

    constructor(props) {
        super(props);
        const { state } = this.props.navigation;
        const { navigate } = this.props.navigation;
        var expense = state.params ? state.params.expense : "<undefined>";
        this.state = {
            type: expense.Type,
            value: expense.Value,
        };
        console.log(this.state.type)
        console.log(this.state.value)
    }

    update = async () => {
        const { state } = this.props.navigation;
        var expense = state.params ? state.params.expense : "<undefined>";
        var expenseId = expense.Id;
        console.log("ID-ul expense-ului este " + expenseId);
        ApiClient.updateExpense(
            expenseId,
            this.state.type,
            this.state.value,
        ).then(console.log("totul e ok la update")).catch(
            (error) => {
                alert(error.message)
            }
            )

    }

    render() {
        const { state } = this.props.navigation;
        var expense = state.params ? state.params.expense : "<undefined>";
        return (
            <View style={styles.container} >
                <TextInput style={styles.input} value={this.state.type}
                    onChangeText={type => this.setState({ type })}
                />
                <TextInput style={styles.input} value={this.state.value.toString()}
                    onChangeText={value => this.setState({ value })}
                />
                <TouchableOpacity
                    style={styles.button}
                    onPress={this.update}
                >
                    <Text style={styles.textBtn}>Update</Text>
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
    }

);