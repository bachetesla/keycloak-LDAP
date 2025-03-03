To **connect LDAP to Keycloak** and **set up Single Sign-On (SSO) for Nextcloud** using Keycloak as the identity provider, follow these steps:

---

### 1. **Configure LDAP in Keycloak**
1. Go to the **Keycloak Admin Console**:
   ```
   http://localhost:8080/
   ```

2. Login with:
    - Username: **admin**
    - Password: **admin**

3. Select your **Realm** (or create a new one).

4. Go to **User Federation** ➡️ **Add Provider** ➡️ **LDAP**.

5. Fill in the LDAP details:
    - **Vendor**: Other
    - **Connection URL**: `ldap://ldap:389`
    - **Bind DN**: `cn=admin,dc=mycompany,dc=local`
    - **Bind Credential**: `admin`
    - **Users DN**: `dc=mycompany,dc=local`
    - **Username LDAP Attribute**: `uid`
    - **RDN LDAP Attribute**: `uid`
    - **UUID LDAP Attribute**: `entryUUID`
    - **User Object Classes**: `inetOrgPerson`
    - Enable **Import Users**
    - Click **Test Connection** and **Test Authentication**

6. Save the settings.

---

### 2. **Create Keycloak Client for Nextcloud**
1. Go to **Clients** ➡️ **Create Client**.

2. Enter:
    - **Client ID**: `nextcloud`
    - **Client Protocol**: `openid-connect`
    - **Root URL**: `http://nextcloud.local`

3. Click **Save**.

4. Configure the Client:
    - **Access Type**: `confidential`
    - **Valid Redirect URIs**: `http://nextcloud.local/*`
    - **Base URL**: `http://nextcloud.local`
    - **Admin URL**: `http://nextcloud.local`
    - **Web Origins**: `http://nextcloud.local`
    - Save.

5. Go to the **Credentials** tab and copy the **Client Secret**.

---

### 3. **Configure Nextcloud**
1. Go to your Nextcloud instance:
   ```
   http://nextcloud.local
   ```

2. Install the **Social Login** App:
    - Go to **Apps**
    - Search for **Social Login**
    - Install and enable it

3. Go to **Settings** ➡️ **Administration** ➡️ **Social Login**.

4. Click **Add Login Provider**.

5. Choose **OpenID Connect** and fill in:
    - **Title**: Keycloak
    - **Client ID**: `nextcloud`
    - **Client Secret**: (Paste the client secret from Keycloak)
    - **Authorize URL**: `http://localhost:8080/realms/{realm_name}/protocol/openid-connect/auth`
    - **Token URL**: `http://localhost:8080/realms/{realm_name}/protocol/openid-connect/token`
    - **User Info URL**: `http://localhost:8080/realms/{realm_name}/protocol/openid-connect/userinfo`
    - **End Session URL**: `http://localhost:8080/realms/{realm_name}/protocol/openid-connect/logout`

6. Save.

---

### 4. **Test SSO**
1. Go to your Nextcloud login page.
2. You will see the **Keycloak Login Button**.
3. Click the button.
4. Login with the **LDAP user** via Keycloak.

---
