angular.module('moment.resources')
    .factory('Invoice', (railsResourceFactory, CacheFactory, UserService) => {
      const resource = railsResourceFactory({
        url: `${CONFIG.RAILS_URL}/invoices`,
        name: 'invoice',
        isArray: true,
        httpConfig: {
          cache: CacheFactory.get('defaultCache'),
        },
      });
      
      resource.oauth = function () {
        return this.$get(`${this.$url()}/oauth`);
      };

      return resource;
    });
