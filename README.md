# security-monkey-cookbook

Installs the (Netflix Security Monkey)[http://securitymonkey.readthedocs.org/en/latest/index.html] 
to monitor AWS security settings.

## Supported Platforms

Ubuntu and RedHat families while running on EC2.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['security-monkey']['secret_key']</tt></td>
    <td>String</td>
    <td>Random string to use for Flask secret key</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['security-monkey']['password_salt']</tt></td>
    <td>String</td>
    <td>Random string to use for Flask salt</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['security-monkey']['mail_sender']</tt></td>
    <td>String</td>
    <td>Email address from which to send reports</td>
    <td><tt>securitymonkey@example.tld</tt></td>
  </tr>
  <tr>
    <td><tt>['security-monkey']['security_team_email']</tt></td>
    <td>String</td>
    <td>Email address to send reports</td>
    <td><tt>securitymonkey@example.tld</tt></td>
  </tr>
</table>

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

## License and Authors

Author:: David F. Severski (<davidski@deadheaven.com>)
