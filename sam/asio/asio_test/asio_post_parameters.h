#pragma once

#include "asio.hpp"

class Parameter
{
public:
	Parameter(int i) {
		n = i;
		std::cout << this << " Parameter(" << n << ")" << std::endl;
	}
	Parameter(const Parameter& para) {
		n = para.n;
		std::cout << this << " Parameter copy(" << n << ")" << std::endl;
	}
	Parameter(Parameter&& para) {
		n = para.n;
		std::cout << this << " Parameter move(" << n << ")" << std::endl;
	}
	~Parameter() {
		std::cout << this << " ~Parameter(" << n << ")" << std::endl;
		n = 0;
	}
	Parameter& operator=(Parameter&& para) {
		n = para.n;
		std::cout << this << " operator=(" << n << ")" << std::endl;
		return *this;
	}
	int n;
};
class test
{
public:
	test() {}
	void init() {
		post();
		post2();
		post3();
		m_ioc.run();
	}

	void post() {
		std::cout << "post()" << std::endl;
		auto param = std::make_shared<Parameter>(9);
		asio::post(m_ioc, std::bind(&test::dealwith, this, param));
	}

	void dealwith(std::shared_ptr<Parameter> para) {
		std::cout << "dealwith(" << para->n << ")" << std::endl;
	}

	template<class T>
	void dealwithT(T&& para) {
		std::cout << "dealwithT(" << para.n << ")" << std::endl;
	}

	void post2() {
		std::cout << "post2()" << std::endl;
		Parameter param(666);
		asio::post(m_ioc, std::bind(&test::dealwithT<Parameter&>, this, std::move(param)));
	}

	void post3() {
		std::cout << "post3()" << std::endl;
		Parameter param(999);
		asio::post(m_ioc, [=]() {
			std::cout << "dealwith pos3(" << param.n << ")" << std::endl;
		});
	}
public:
	asio::io_context m_ioc;
};
	