# security-monkey-cookbook

Installs the (Netflix Security Monkey)[http://securitymonkey.readthedocs.org/en/latest/index.html] 
to monitor AWS security settings.

## Supported Platforms

Ubuntu while running on EC2.

## Attributes

| Key | Type | Description | Default |
|-----|------|-------------|---------|
| `['security-monkey']['secret_key']` | String | Random string to use for Flask secret key | `true` |
| `['security-monkey']['password_salt']` | String | Random string to use for Flask salt | `true` | 
| `['security-monkey']['mail_sender']` | String | Email address from which to send reports | `securitymonkey@example.tld` |
| `['security-monkey']['security_team_email']` | String | Email address to send reports | `securitymonkey@example.tld` |

## Usage

### security-monkey::default

Include `security-monkey` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[security-monkey::default]"
  ]
}
```
### security-monkey::nginx

Include `security-monkey` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[security-monkey::nginx]"
  ]
}
```


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

### To Dos

- [ ] Write tests
- [ ] Verify on EC2 (vagrant DNS resolution breaks ATM)
- [ ] Better idempotency
- [ ] Optional use of RDS vs. postgres
- [ ] Integrate with SES
- [ ] Finish nginx integration
  - [X] Self-signed certificate generation
- [ ] Secret and salt random generation

## License and Authors

Author:: David F. Severski (<davidski@deadheaven.com>)
