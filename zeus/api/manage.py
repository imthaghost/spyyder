from flask_migrate import Migrate, MigrateCommand
from flask_script import Manager
import os

import zeus_api


zeus_api.app.config.from_object(os.environ['APP_SETTINGS'])
print(zeus_api.app)
migrate = Migrate(zeus_api.app, zeus_api.database)
print(zeus_api.database, zeus_api.app)
manager = Manager(zeus_api.app)


manager.add_command('db', MigrateCommand)


if __name__ == '__main__':
    manager.run()
