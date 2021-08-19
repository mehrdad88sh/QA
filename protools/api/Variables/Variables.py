class Variables(object):

    def __init__(self):
        pass

    def get_variables(self):
        return {
        'staging': 'https://staging.mielse.com',
        'stagingMock': 'https://staging.mielse.com/mock/getCode?mobile',
        'pr': 'https://pr10303.mielse.com',
        'prMock': 'https://pr10303.mielse.com/mock/getCode?mobile'
}
