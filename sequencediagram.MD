_@startuml
actor User
entity Nextcloud
entity Keycloak
entity LDAP

User -> Nextcloud : Login Request
Nextcloud -> Keycloak : Authenticate via OpenID Connect
Keycloak -> LDAP : Validate Credentials
LDAP --> Keycloak : Credentials Valid
Keycloak --> Nextcloud : Access Token
Nextcloud --> User : Access Granted
@enduml_
