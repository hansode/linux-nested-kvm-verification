Linux Nested KVM Verification
=============================

System Requirements
-------------------

+ Fedora 20
+ CentOS 6.5

System Configuration Diagram
----------------------------

````
       ~~~
        |
+-------|-------+ Edge Switch
| o o o o o o o |
+---|-----------+
    |
+---|-----------------------------------------+
|   |                             (BareMetal) |
|  em2 192.168.1.xx/24                        |
|   A                                         |
|   | <MASQUERADE>                            |
|   |                                         |
| nestbr0 172.16.2.2/24                       |
| +---+                                       |
| | o |          +--------------------------+ |
| | o |          |                   (KVM1) | |
| | o--- tapXXX --- eth0 172.16.2.xx/24     | |
| | o |          |   A                      | |
| | o |          |   | <MASQUERADE>         | |
| | o |          |   |                      | |
| | o |          | vboxbr0 10.0.2.0/24      | |
| | o |          | +---+                    | |
| | o |          | | o |           +------+ | |
| | o |          | | o |           |(KVM2)| | |
| | o |          | | o |           |      | | |
| | o |          | | o--- tapXXX --- eth0 | | |
| | o |          | | o |           |      | | |
| | o |          | | o |           +------+ | |
| | o |          | +---+                    | |
| | o |          +--------------------------+ |
| +---+                                       |
|                                             |
+---------------------------------------------+
````

KVM Options
-----------

| KVM   | cpu           |
|:------|:--------------|
| KVM1  | `qemu64,+vmx` |
| KVM2  | `host`        |
