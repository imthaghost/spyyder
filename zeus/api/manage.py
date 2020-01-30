from flask_migrate import Migrate, MigrateCommand
from flask_script import Manager
import os

import server


server.app.config.from_object(os.environ['APP_SETTINGS'])
print(server.app)
migrate = Migrate(server.app, server.db)
print(server.db, server.app)
manager = Manager(server.app)


manager.add_command('db', MigrateCommand)


if __name__ == '__main__':
    manager.run()
