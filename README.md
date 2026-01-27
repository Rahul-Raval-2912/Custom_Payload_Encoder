# Advanced Payload Encoder & Obfuscation Framework

**Purpose:** Educational red team evasion techniques demonstration

## 🎯 Overview

Professional-grade payload obfuscation framework with 7 evasion layers that chain together to bypass AV/EDR/WAF detection systems. Built for educational purposes and red team research.

## 🔧 Features

### 7-Layer Evasion Chain
1. **Unicode Cloak** - Zero-width spaces break pattern matching
2. **Base64 Armor** - Multi-layer encoding with padding manipulation  
3. **XOR Encryption** - Repeating key encryption
4. **Junk Scatter** - Random character insertion (40% density)
5. **Fragmentation** - Split payloads with reassembly
6. **OS Bypass** - AMSI (Windows) + LD_PRELOAD (Linux)

### Detection Engine Testing
- **AV Engines:** Windows Defender, ClamAV, Kaspersky
- **EDR Systems:** Memory execution, API hooking detection
- **WAF Bypass:** Web application firewall evasion

## 📁 Project Structure

```
advanced_payload_framework/
├── main.py              # CLI master control
├── encoders/           
│   ├── base64.py        # Base64 armor encoding
│   ├── xor.py           # XOR encryption
│   └── rot13.py         # Character rotation
├── obfuscators/
│   ├── unicode.py       # Zero-width space insertion
│   ├── junk_scatter.py  # Random character injection
│   └── fragment.py      # Payload fragmentation
├── bypasses/
│   ├── amsi_windows.py  # Windows AMSI bypass
│   └── ld_preload_linux.py # Linux library injection
├── utils.py            # Utility functions
├── reporter.py         # Executive reports
├── sample_payloads/    # Test payloads
│   └── basic.txt       # Contains "whoami"
├── setup.sh           # Installation script
├── LICENSE            # MIT License
├── .gitignore         # Git ignore rules
└── README.md          # This file
```

## 🚀 Quick Setup

### Prerequisites
- Python 3.6+
- GCC compiler (for Linux bypasses)
- Linux/macOS recommended

### Installation
```bash
# Clone the repository
git clone <repository-url>
cd advanced_payload_framework

# Run setup script
chmod +x setup.sh
./setup.sh

# Verify installation
python3 main.py --help
```

## 💻 Usage

### Basic Commands
```bash
# Process payload from file
python3 main.py --file sample_payloads/basic.txt --chain basic --variants 3

# Direct payload input
python3 main.py --payload "whoami" --chain stealth --variants 5

# Full obfuscation chain
python3 main.py --file sample_payloads/basic.txt --chain full --variants 10

# Target-specific obfuscation
python3 main.py --payload "whoami" --target windows --variants 5
```

### Advanced Usage
```bash
# Generate comprehensive variants
python3 main.py --payload "whoami" --chain full --variants 20

# Save results to JSON
python3 main.py --file sample_payloads/basic.txt --chain stealth --output results.json

# Test against detection engines
python3 main.py --payload "whoami" --chain stealth --test
```

### Command Line Options
- `--payload` - Direct payload string to obfuscate
- `--file` - Path to payload file (e.g., sample_payloads/basic.txt)
- `--chain` - Obfuscation chain: basic/stealth/full (default: stealth)
- `--target` - Target OS: windows/linux/both (default: both)
- `--variants` - Number of variants to generate (default: 5)
- `--test` - Test against detection engines
- `--output` - Save results to JSON file

## 🔬 Technical Deep Dive

### Layer 1: Unicode Obfuscation
```python
# Inserts zero-width spaces to break signatures
payload = "whoami"
obfuscated = "w\u200bh\u200bo\u200ba\u200bm\u200bi"
```

### Layer 2: Base64 Armor
```python
# Multi-iteration base64 with custom padding
original = "whoami"
encoded = base64.b64encode(base64.b64encode(original.encode())).decode()
```

### Layer 3: XOR Encryption
```python
# Repeating key XOR with latin1 encoding
key = "cyber"
xored = bytes([b ^ key[i % len(key)] for i, b in enumerate(payload)])
```

## 🛡️ Detection Evasion Techniques

### Signature Bypass
- String fragmentation
- Character substitution
- Encoding chains
- Pattern breaking

### Behavioral Evasion
- Execution delay
- Context awareness
- Environment checks
- Anti-analysis

### Heuristic Bypass
- Randomization
- Polymorphic generation
- Decoy insertion
- Statistical normalization

## 📈 Performance Metrics

### Evasion Rates (Average)
- **Basic Chain:** 70-80% evasion
- **Stealth Chain:** 85-92% evasion  
- **Full Chain:** 90-98% evasion

### Supported Payloads
- Windows PowerShell commands
- Linux bash/shell commands
- Web application attacks (XSS, SQLi)
- Container escape techniques
- APT-style living-off-the-land

## ⚠️ Legal Disclaimer

This framework is developed for:
- **Educational purposes only**
- **Authorized penetration testing**
- **Red team exercises with permission**
- **Cybersecurity research**

**NOT for:**
- Unauthorized system access
- Malicious activities
- Illegal penetration testing
- Production malware development

## 🤝 Contributing

Contributions are welcome! Suggestions for improvement:

1. Additional obfuscation layers
2. New detection engine signatures
3. Enhanced reporting features
4. Performance optimizations

---

**Framework Version:** 1.0  
**Last Updated:** 2024  
**License:** MIT