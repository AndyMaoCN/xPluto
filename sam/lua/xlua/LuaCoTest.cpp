#include "LuaCoTest.h"


#define SOL_ALL_SAFETIES_ON 1
#include <sol/sol.hpp>

asio::io_context lua_context_;

int CoTest()
{
	auto work = asio::make_work_guard(lua_context_);

	asio::signal_set singel(lua_context_, SIGINT, SIGTERM);
	singel.async_wait([](const asio::error_code& ec, int sig) {
		if (sig == SIGINT) {
			std::cout << "Capture CTRL+C" << std::endl;
		}
		else {
			std::cout << "Capture " << sig << std::endl;
		}
		lua_context_.stop();
	});
	const auto& co_lua_script = R"(
function corun(co, tn)
	print("co run.")
	tn:Execute(function(n) print(n) end)
	local n = tn:Execute()
	print("co:", n)
end

function OnStart()
	local tn = create_tn()
	local n = tn:Execute()
	print("Main:", n)
	local co = coroutine.create(corun)
	coroutine.resume(co, co, tn)
end
)";

	sol::state lua;
	lua.open_libraries(sol::lib::base, sol::lib::coroutine);

	lua.new_usertype<TestNode>( "TestNode", //sol::constructors<TestNode(sol::this_state)>(),
		"Execute",
		&TestNode::Execute);
	lua["create_tn"] = [](sol::this_state L) {return std::make_shared<TestNode>(L); };

	lua.script(co_lua_script);

	auto func = lua.get<sol::main_protected_function>("OnStart");
	if (func) {
		func.call();
	}

	lua_context_.run();

	return 0;
}