#include <Windows.h>

#include <chrono>
#include <iostream>
#include <thread>

#include "entity.hpp"
#include "render_api.hpp"
#include "search.hpp"
#include "ui.hpp"
#include "version.hpp"
#include "window_api.hpp"

using namespace std::chrono_literals;

BOOL WINAPI ctrl_handler(DWORD ctrl_type)
{
    switch (ctrl_type)
    {
    case CTRL_C_EVENT:
    case CTRL_BREAK_EVENT:
    case CTRL_CLOSE_EVENT:
    {
        DEBUG("Console detached, you can now close this window.");
        FreeConsole();
        return TRUE;
    }
    }
    return TRUE;
}

void attach_stdout(DWORD pid)
{
    size_t env_var_size;
    getenv_s(&env_var_size, NULL, 0, "OL_DEBUG");
    if (env_var_size > 0)
    {
        AttachConsole(pid);
        SetConsoleCtrlHandler(ctrl_handler, 1);

        FILE* stream;
        freopen_s(&stream, "CONOUT$", "w", stdout);
        freopen_s(&stream, "CONOUT$", "w", stderr);
        freopen_s(&stream, "CONIN$", "r", stdin);
    }
}

extern "C" __declspec(dllexport) void run(DWORD pid)
{
    attach_stdout(pid);
    FILE* fp;
    auto err = fopen_s(&fp, "spelunky.log", "a");
    if (err == 0)
    {
        fputs("Overlunky loaded\n", fp);
        fclose(fp);
    }
    DEBUG("Game injected! Press Ctrl+C to detach this window from the process.");

    register_application_version(fmt::format("Overlunky {}", get_version()));
    preload_addresses();

    while (true)
    {
        auto entities = list_entities();
        if (entities.size() >= 850)
        {
            DEBUG("Found {} entities, that's enough", entities.size());
            std::this_thread::sleep_for(100ms);
            create_box(entities);
            DEBUG("Added {} entities", entities.size());
            break;
        }
        else if (entities.size() > 0)
        {
            DEBUG("Found {} entities", entities.size());
        }
        std::this_thread::sleep_for(100ms);
    }

    auto& api = RenderAPI::get();
    init_ui();
    init_hooks((void*)api.swap_chain());
    size_t env_var_size;
    getenv_s(&env_var_size, NULL, 0, "OL_DEBUG");
    if (env_var_size > 0)
    {
        DEBUG("Running in debug mode.");
        do
        {
            std::string line;
            std::getline(std::cin, line);
            if (std::cin.fail() || std::cin.eof())
            {
                std::cin.clear();
            }
        } while (true);
    }
}
