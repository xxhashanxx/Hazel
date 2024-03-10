#pragma once


#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();
int main(int argc, char** argv)
{
	Hazel::Log::Init();
	HZ_CORE_TRACE("Initilized Log!");
	HZ_WARN("Initilized Log!");
	auto app = Hazel::CreateApplication();
	app->Run();
	delete app;
}
#endif