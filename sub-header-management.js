require('./sub-header-management.scss');
const subHeaderManagementTemplate = require('./sub-header-management.html');
const clientsModalTemplate = require('../clients/add-edit-modal/clients-modal.html');

angular.module('moment.components')
  .directive('subHeaderManagement', () => ({
    template: subHeaderManagementTemplate,
    transclude: {
      search: '?search',
    },
    scope: {},
    replace: true,
    controller($scope, $transclude, $state, $uibModal, Organization, Invoice, $window) {
      $scope.$state = $state;

      $scope.orgId = Organization.ID;
      $scope.orgName = Organization.NAME;

      $scope.back = function () {
        $state.go($state.current.data.back);
      };

      $scope.oauth = function () {
        Invoice.oauth().then((res) => {
          const url = res.scheme + '://' + res.host + res.path + '?' + res.query;
          $window.location.href = url;
        });
      }

      $scope.canTranscludeSearch = () => $transclude.isSlotFilled('search');
    },
  }));
