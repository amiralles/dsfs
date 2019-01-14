#!/bin/bash

function main {
	failling_tests=()
	
	ruby "./avl_tree_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("AVL Tree") 
	fi

	ruby "./binary_tree_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Binary Tree")
	fi

	ruby "./circular_linked_list_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Ciscular Linked List")
	fi

	ruby "./doubly_linked_list_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Doubly linked list")
	fi

	ruby "./graph_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Graph")
	fi

	ruby "./hash_table_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Hash Table")
	fi

	ruby "./plist_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Persistent List")
	fi

	ruby "./queue_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Queue")
	fi

	ruby "./set_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Set")
	fi

	ruby "./singly_linked_list_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Singly Linked List")
	fi

	ruby "./stack_fixture.rb"
	if [[ $? != 0 ]]
	then
		failling_tests+=("Stack")
	fi

	len="${#failling_tests[@]}"
	if [[ $len -gt 0 ]]
	then
		for (( i=0; i<$len; i++ )); do 
			printf '\e[1;31m%s (FAILED).\e[m\n' "${failling_tests[$i]}"
		done
	else
		printf '\e[1;32mAll Tests Passed!\e[0m\n'
	fi
}

main
