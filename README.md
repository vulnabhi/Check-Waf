A simple Bash script to automate Web Application Firewall (WAF) detection using wafw00f for a list of target domains.

📌 Features

    Detects WAFs across multiple domains.

    Easy to use and modify.

    Skips empty lines automatically.

    Clean, readable output.

📦 Requirements

    bash (default on most Linux systems)

    wafw00f

Install wafw00f using pip:

pip install wafw00f

🛠️ How to Use

    Clone this repo (or copy the script):

git clone https://github.com/yourusername/check_waf.sh.git
cd check_waf.sh

Create a file called domains.txt with one domain per line:

https://example.com
http://testsite.com
https://secure.example.org

Make the script executable:

chmod +x check_waf.sh

Run the script:

./check_waf.sh
