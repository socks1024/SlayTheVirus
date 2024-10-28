class_name BaseState
extends Node

var state_machine:CardStateMachine
var card_data


func get_state_machine():
	return state_machine

func get_current_state() -> BaseState:
	return state_machine.get_current_state() as BaseState



## 进入到这个状态时
func enter(card_data):
	self.card_data = card_data

## 退出这个状态时
func exit():
	pass

## 执行到当前状态时，会切换为调用这个方法
func state_process(delta):
	pass

## 切换状态
func switch_to(state,data):
	state_machine.switch_to(state,data)
