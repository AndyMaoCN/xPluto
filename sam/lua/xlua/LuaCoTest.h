#include "lua_coroutine.h"
#include "asio.hpp"
#include <iostream>
#pragma once

int CoTest();

extern asio::io_context lua_context_;

class TestNode : public std::enable_shared_from_this<TestNode>
{
public:
	TestNode(sol::this_state L) { std::cout << "TestNode()" << std::endl; }
	virtual ~TestNode(){ std::cout << "~TestNode()" << std::endl; }

	template <typename Fn>
	void AsyncFn(Fn&& fn) {
		auto self = shared_from_this();
		asio::post(lua_context_, [self, this, fn = std::move(fn)] {
			std::cout << "AsyncFn lambda " << self.use_count() << std::endl;
		});
	}

	sol::variadic_results Execute(sol::object cb, sol::this_state L) {
		std::cout << "Execute " << (int)cb.get_type()  << " state:" << L.lua_state() << std::endl;
		sol::variadic_results rets;
		auto run_L = L.lua_state();
		if (cb.get_type() == sol::type::function) {
			auto idx = append_object_to_registery(run_L, cb);
			//auto self = shared_from_this();
			asio::post(lua_context_, [self = shared_from_this(), this, run_L, idx]() {
				auto cb = find_object_in_registery(run_L, idx);
				cb.as<sol::main_protected_function>().call(self.use_count());
				remove_object_from_registery(run_L, idx);
			});
		}
		else {
			if (sol::stack::is_main_thread(run_L)) {
				rets.push_back({L, sol::in_place, 999});
				return rets;
			}
			else {
				auto idx = append_current_coroutine_to_registery(run_L);
				asio::post(lua_context_, [self = shared_from_this(), this, run_L, idx]() {
					remove_object_from_registery(run_L, idx);
					co_mult_results(run_L, self.use_count());
				});
			}
			return lua_yield(run_L, 0);
		}
		return rets;
	}
/*
	void init() {
		thread_ = std::thread([this]() {
			auto work = asio::make_work_guard(ioc_);
			ioc_.run();
		});
	}

	void stop() {
		ioc_.stop();
		if (thread_.joinable()) {
			thread_.join();
		}
	}
public:
	asio::io_context	ioc_;
	std::thread			thread_;*/
};