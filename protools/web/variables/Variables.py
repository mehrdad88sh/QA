class Variables(object):

    def __init__(self):
        pass

    def get_variables(self):
        return {
        'staging': 'https://trumpet:newsite@staging.mielse.com/pro',
        'pr': 'https://trumpet:newsite@pr9870.mielse.com/pro',
        'prMock': 'https://pr9870.mielse.com/mock/getCode?mobile',
        'stagingMock': 'https://staging.mielse.com/mock/getCode?mobile',
    }
