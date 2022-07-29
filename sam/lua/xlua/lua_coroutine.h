#pragma once
#include <sol/sol.hpp>

template<typename T>
inline int push_value(lua_State* L, T& t) {
	sol::stack::unqualified_pusher<T> p{};
	(void)p;
	return p.push(L, t);
}

//
template<typename... Args>
inline void co_mult_results(lua_State* L, Args&& ... args) {
	auto status = lua_status(L);
	if (status != LUA_YIELD) {
		//协程不是挂起状态，无法传递返回值
		return;
	}
	auto pnum = lua_gettop(L);
	if (pnum > 0) {
		lua_pop(L, pnum);
	}
	auto nargs = sizeof ... (args);
	if (!lua_checkstack(L, nargs)) {
		return; //栈空间不够
	}
	auto count = 0;
	((count += push_value(L, args)), ...);
#ifdef LUA_JIT
	if (lua_resume(L, NULL, count) == LUA_YIELD) {
		return;
	}
#else
	int nresult = 0;
	if (lua_resume(L, NULL, count, &nresult) == LUA_YIELD) {
		return;
	}
#endif
}

inline static int hook_continue_k(lua_State* L, int status, lua_KContext ctx) {
	auto count = lua_gettop(L);
	return count;
}

inline sol::object current_coroutine(lua_State* L) {
	lua_pushthread(L);
	sol::basic_thread<sol::thread> result(L);
	lua_pop(L, 1);
	return result;
}

inline int append_current_coroutine_to_registery(lua_State* L) {
	lua_pushthread(L);
	return luaL_ref(L, LUA_REGISTRYINDEX);
}

inline int append_object_to_registery(lua_State* L, sol::object object) {
	sol::stack::push(L, object);
	return luaL_ref(L, LUA_REGISTRYINDEX);
}

inline void remove_object_from_registery(lua_State* L, int ref_index) {
	luaL_unref(L, LUA_REGISTRYINDEX, ref_index);
}

inline sol::object find_object_in_registery(lua_State* L, int ref_index) {
	lua_rawgeti(L, LUA_REGISTRYINDEX, ref_index);
	sol::object result(L);
	lua_pop(L, 1);
	return result;
}