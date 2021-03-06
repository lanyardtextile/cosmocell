#include <test/layer/network_speed.hpp>

// Initialize layer.
cosmocell::layer::test::network_speed::network_speed() : m_socket(12345)
{

}

// Starts speed test.
void cosmocell::layer::test::network_speed::prepare()
{
    uint64_t data = 9999;

    // Introductory message.
    std::cout << std::endl << "Measuring network performance..." << std::endl;

    // Prepare buffer to send over socket.
    m_buffer.write(data);

    // Start timer.
    m_timer.reset();
}

// Perform speed test.
bool cosmocell::layer::test::network_speed::execute()
{
    static uint64_t count_out = 0, count_in = 0;
    std::string address;

    // Send data.
    address = "127.0.0.1";
    if (m_socket.send(m_buffer, address)) {
        count_out++;
    }
    while (m_socket.receive(m_buffer_dummy, address)) {
        count_in++;
    }

    // Stop test after three seconds.
    if (m_timer.elapsed() > 3) {
        std::cout << " - Sent " << count_out << " messages @ " << (m_socket.rate_out() * 8 / 1000000) << " Mbps" << std::endl
                  << " - Received " << count_in << " messages @ " << (m_socket.rate_in() * 8 / 1000000) << " Mbps" <<  std::endl;
        return false;
    }
    return true;
}
