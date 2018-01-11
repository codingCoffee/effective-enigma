# attempt at doing a post request in frappe
payload = {
    'usr': 'Administrator',
    'pwd': 'admin'
}

# Use 'with' to ensure the session context is closed after use.
with requests.Session() as s:
    p = s.post('http://agri.erp.2:8000/api/method/login', data=payload)
    # print the html returned or something more intelligent to see if it's a successful login page.
    print p.text

    p = s.get('http://agri.erp.2:8000/api/method/frappe.auth.get_logged_user')
    print p.text

    payload = {
        "data": {
            "shareholder": "Robert"
        }
    }
    payload = json.dumps(payload)

    # An authorised request.
    # p = s.post("http://agri.erp.2:8000/api/resource/Shareholder", '{"data":{"shareholder": "Robert"}}')
    p = s.post("http://agri.erp.2:8000/api/resource/Shareholder", data=payload)
    # request working but data is not getting filled
    print p.json()