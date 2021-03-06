#include <client/layer_root.hpp>

int main()
{
    // Run client.
    try {
        cosmodon::layer *program = new cosmocell::layer::client::root;
        cosmodon::engine engine(program);
        engine.execute();
    }

    // Catch errors.
    catch (const cosmodon::exception::base &e) {
        std::cout << std::endl << "[error] " << e.what() << std::endl;
    }
    return 0;
}
