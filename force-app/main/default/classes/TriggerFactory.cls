public with sharing class TriggerFactory {

    public static void createHandler(Schema.SObjectType sObjectType) {
        String handlerName = sObjectType.getDescribe().getName()
                .removeEnd('__c').replaceAll('_', '').replace('clubR', '') + 'Handler';
        TriggerHandlerInterface handler = create(handlerName);
        if (handler == null) {
            throw new TriggerException('No Trigger Handler registered for Object Type: ' + sObjectType);
        }

        execute(handler);
    }

    private static void execute(TriggerHandlerInterface handler) {
        if (Trigger.isBefore) {
            handler.bulkBefore();
            if (Trigger.isDelete) {
                handler.beforeDelete(Trigger.oldMap);
            } else if (Trigger.isInsert) {
                handler.beforeInsert(Trigger.new);
            } else if (Trigger.isUpdate) {
                handler.beforeUpdate(Trigger.oldMap, Trigger.newMap);
            }
        } else {
            handler.bulkAfter();
            if (Trigger.isDelete) {
                handler.afterDelete(Trigger.old);
            } else if (Trigger.isInsert) {
                handler.afterInsert(Trigger.newMap);
            } else if (Trigger.isUpdate) {
                for (SObject sObjectType : Trigger.old) {
                    handler.afterUpdate(Trigger.oldMap, Trigger.newMap);
                }
            }
        }
        handler.andFinally();
    }

    private static TriggerHandlerInterface create(String handlerName) {
        System.Type classType = Type.forName(handlerName);
        if (classType == null) {
            throw new TriggerException('Not a valid class name for ' + handlerName);
        }

        Object handler = classType.newInstance();

        if (!(handler instanceof TriggerHandlerInterface)) {
            throw new TriggerException('Not a valid instance of Trigger Handler for class name ' + handlerName);
        }

        return (TriggerHandlerInterface) handler;

    }
}