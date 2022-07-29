// xlua.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include <iostream>

#include "sol/sol.hpp"

#include <string>
#include <set>

#include "LuaCoTest.h"

int main()
{
	CoTest();
/*
	sol::state lua;

	lua.set_function("f", []() {
		std::set<std::string> results{
			"arf", "bark", "woof"
		};
		return sol::as_returns(std::move(results));
		});

	lua.script("v1, v2, v3 = f()");

	std::string v1 = lua["v1"];
	std::string v2 = lua["v2"];
	std::string v3 = lua["v3"];

	sol_c_assert(v1 == "arf");
	sol_c_assert(v2 == "bark");
	sol_c_assert(v3 == "woof");

    std::cout << "Hello World!\n";
	*/
	return 0;
}