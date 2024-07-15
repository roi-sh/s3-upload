class BytesConvertor:
    KB = 1024
    MB = 1024 * KB
    MAX_MB = 1
    MIN_MB = 0


class FileType:
    SUPPORTED_FILE_TYPES = {
        'image/png': 'png',
        'image/jpeg': 'jpg',
        'application/pdf/': 'pdf'
    }