pip install opencolorio
ociocpuinfo
git clone https://github.com/analogstudio/OpenColorIO-Config-ACES-releases
git clone https://github.com/sobotka/natron-ocioconfig
git clone https://github.com/sobotka/nikonD5200ocio
git clone https://github.com/sobotka/SB2383-Configuration
git clone https://github.com/sobotka/spectral-cycles-ocio-config

ocioarchive reference-config-v1.0.0_aces-v1.3_ocio-v2.1 --iconfig "./OpenColorIO-Config-ACES-releases/v1.0.0/reference-config-v1.0.0_aces-v1.3_ocio-v2.1.ocio"
ocioarchive reference-config-v3.0.0_aces-v2.0_ocio-v2.4 --iconfig "./OpenColorIO-Config-ACES-releases/v3.0.0/reference-config-v3.0.0_aces-v2.0_ocio-v2.4.ocio"
ocioarchive reference-config-v4.0.0_aces-v2.0_ocio-v2.5 --iconfig "./OpenColorIO-Config-ACES-releases/v4.0.0/reference-config-v4.0.0_aces-v2.0_ocio-v2.5.ocio"
ocioarchive natron-ocioconfig --iconfig "./natron-ocioconfig/config.ocio"
ocioarchive nikonD5200ocio --iconfig "./nikonD5200ocio/config.ocio"
ocioarchive spectral-cycles-ocio-config --iconfig "./spectral-cycles-ocio-config/config.ocio"
ocioarchive SB2383-Configuration --iconfig "./SB2383-Configuration/config.ocio"
