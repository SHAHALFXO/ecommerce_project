const API_BASE = 'http://127.0.0.1:8080';



async function safeFetch(url, opts = {}) {
    try {
        const res = await fetch(url, opts);
        const data = await res.json().catch(() => ({}));
        return data;
    } catch (e) {
        return { error: 'network error' };
    }
}

async function apiSignup(email, password) {
    return safeFetch(`${API_BASE}/auth/signup`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
    });
}

async function apiLogin(email, password) {
    return safeFetch(`${API_BASE}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password })
    });
}

async function apiGetProfile(token) {
    return safeFetch(`${API_BASE}/me/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + token
        }
    });
}
